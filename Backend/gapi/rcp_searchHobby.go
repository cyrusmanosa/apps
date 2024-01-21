package gapi

import (
	db "Backend/db/sqlc"
	info "Backend/db/sqlc/info"
	"Backend/pb"
	"context"
	"fmt"
<<<<<<< HEAD
=======
	"math/rand"
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a

	"github.com/google/uuid"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

<<<<<<< HEAD
func (server *Server) SearchTargetHobby(ctx context.Context, req *pb.SearchRequestH) (*pb.SearchResponseH, error) {
=======
func (server *Server) SearchTargetHobby(ctx context.Context, req *pb.SearchRequest) (*pb.SearchResponse, error) {
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a
	Gid, err := uuid.Parse(req.GetSessionID())
	if err != nil {
		return nil, status.Errorf(codes.Internal, "Session ID Error: %s", err)
	}
	token, err := server.infoStore.GetSession(ctx, Gid)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "authID Error: %s", err)
	}
<<<<<<< HEAD

=======
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a
	_, err = server.tokenMaker.VerifyToken(token.AccessToken)
	if err != nil {
		return nil, fmt.Errorf("invalid access token: %v", err)
	}
	myHobby, err := server.infoStore.GetHobby(ctx, token.UserID)
	if err != nil {
		errCode := db.ErrorCode(err)
		if errCode == db.ForeignKeyViolation || errCode == db.UniqueViolation {
			return nil, status.Errorf(codes.NotFound, "user not found")
		}
		return nil, status.Errorf(codes.Internal, "failed to input UserID: %s", err)
	}

	/// Search start :: 50% Up
	datac := info.CanChangeSearchHobbyParams{
		UserID:        token.UserID,
		City:          nil,
		Speaklanguage: nil,
		HobbyType:     &myHobby.FindType,
		Experience:    &myHobby.Experience,
	}
	Cc, err1 := server.infoStore.CanChangeSearchHobby(ctx, datac)
	if err1 != nil {
		errCode := db.ErrorCode(err1)
		if errCode == db.ForeignKeyViolation || errCode == db.UniqueViolation {
			return nil, status.Errorf(codes.NotFound, "user not found")
		}
		return nil, status.Errorf(codes.NotFound, "No Data")
	}

	if len(Cc) > 0 {
		C_step1_75, C_step1_63 := checkHobby63(Cc, myHobby)

		// 75% to take Fix Data
		if len(C_step1_75) > 0 {
			var F_step2_75 []info.Fixinformation
			for i := 0; i < len(C_step1_75); i++ {
				CF, err1 := server.infoStore.GetUserFixInformation(ctx, C_step1_75[i].UserID)
				if err1 != nil {
<<<<<<< HEAD
					if i < len(C_step1_75) {
						continue
					}
=======
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a
					return nil, status.Errorf(codes.Internal, "failed to get user with Fix")
				}
				F_step2_75 = append(F_step2_75, CF)
			}
<<<<<<< HEAD

			if len(F_step2_75) > 0 {
				full, msg, le := checkHobby100(F_step2_75, myHobby)
				// 100%
				if len(full) > 0 {
					return &pb.SearchResponseH{
						Resu: convertSearchH(full, le, msg),
					}, nil
				}
=======
			if len(F_step2_75) > 0 {
				full, msg := checkHobby100(F_step2_75, myHobby)
				// 100%
				if full > 0 {
					return &pb.SearchResponse{
						Result: int32(full),
						Rank:   msg,
					}, nil
				}
			} else {
				return &pb.SearchResponse{
					Result: C_step1_75[rand.Intn(len(C_step1_75))].UserID,
					Rank:   "75%",
				}, nil
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a
			}
		}

		// 62.5% to take Fix Data
		if len(C_step1_63) > 0 {
<<<<<<< HEAD
			var F_step2_63 []info.Fixinformation
			for i := 0; i < len(C_step1_63); i++ {
				CF, err1 := server.infoStore.GetUserFixInformation(ctx, C_step1_63[i].UserID)
				if err1 != nil {
					if i < len(C_step1_63) {
						continue
					}
					return nil, status.Errorf(codes.Internal, "failed to get user with Fix")
				}
				F_step2_63 = append(F_step2_63, CF)
			}

			if len(F_step2_63) > 0 {
				f75, msg, le := checkHobby100(F_step2_63, myHobby)
				// 62.5% to 75%
				if len(f75) != 0 {
					return &pb.SearchResponseH{
						Resu: convertSearchH(f75, le, msg),
					}, nil
				}
=======
			var F_step2_50 []info.Fixinformation
			for i := 0; i < len(C_step1_63); i++ {
				CF, err1 := server.infoStore.GetUserFixInformation(ctx, C_step1_63[i].UserID)
				if err1 != nil {
					return nil, status.Errorf(codes.Internal, "failed to get user with Fix")
				}
				F_step2_50 = append(F_step2_50, CF)
			}
			if len(F_step2_50) > 0 {
				f75, msg := checkHobby75(F_step2_50, myHobby)
				// 62.5% to 75%
				if f75 != 0 {
					return &pb.SearchResponse{
						Result: int32(f75),
						Rank:   msg,
					}, nil
				}
			} else {
				return &pb.SearchResponse{
					Result: C_step1_63[rand.Intn(len(C_step1_63))].UserID,
					Rank:   "50%",
				}, nil
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a
			}
		}

	} else {
<<<<<<< HEAD
		var Cc_id []int32
		for i := range Cc {
			Cc_id = append(Cc_id, Cc[i].UserID)
		}
		return &pb.SearchResponseH{
			Resu: convertSearchH(Cc_id, int32(len(Cc)), "50%"),
		}, nil
	}
	// 50% 未満
	return &pb.SearchResponseH{
		Resu: convertSearchH(nil, 0, "No search results found"),
=======
		return &pb.SearchResponse{
			Result: Cc[rand.Intn(len(Cc))].UserID,
			Rank:   "50%",
		}, nil
	}
	// 50% 未満
	return &pb.SearchResponse{
		Result: 0,
		Rank:   "No search results found",
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a
	}, nil
}

func checkHobby63(Cc []info.Canchangeinformation, myHobby info.Hobby) ([]info.Canchangeinformation, []info.Canchangeinformation) {
	// if Max :: 62.5% to 75%
	var C_step1_63 []info.Canchangeinformation
	var C_step1_75 []info.Canchangeinformation
	for i := 0; i < len(Cc); i++ {
		for j := 0; j < len(myHobby.City); j++ {
			if Cc[i].City == myHobby.City[j] {
				for k := 0; k < len(myHobby.Speaklanguage); k++ {
					if Cc[i].Speaklanguage[j] == myHobby.Speaklanguage[k] {
						C_step1_75 = append(C_step1_75, Cc[i])
						break
					}
				}
				C_step1_63 = append(C_step1_63, Cc[i])
			}
		}
	}
	return C_step1_75, C_step1_63
}

<<<<<<< HEAD
func checkHobby100(F_step2_75 []info.Fixinformation, myHobby info.Hobby) ([]int32, string, int32) {
	var step2Result75 []info.Fixinformation
	var step2Result100 []info.Fixinformation
	// 100% proccess
	for i := 0; i < len(F_step2_75); i++ {
		if F_step2_75[i].Age >= myHobby.Era && F_step2_75[i].Age < myHobby.Era+10 && F_step2_75[i].Gender == myHobby.Gender {
			step2Result100 = append(step2Result100, F_step2_75[i])
		}
	}
	// 75% Proccess
	for i := 0; i < len(F_step2_75); i++ {
		if F_step2_75[i].Age >= myHobby.Era && F_step2_75[i].Age < myHobby.Era+10 || F_step2_75[i].Gender == myHobby.Gender {
			step2Result75 = append(step2Result75, F_step2_75[i])
		}
	}

	// 100 % return
	if len(step2Result100) > 0 {
		var step2Result100_id []int32
		for i := range step2Result100 {
			step2Result100_id = append(step2Result100_id, step2Result100[i].UserID)
		}
		return step2Result100_id, "100%", int32(len(step2Result100_id))
	}
	// 75 % return
	if len(step2Result75) > 0 {
		var step2Result75_id []int32
		for i := range step2Result75 {
			step2Result75_id = append(step2Result75_id, step2Result75[i].UserID)
		}
		return step2Result75_id, "63%", int32(len(step2Result75_id))
	}

	return nil, "Not Found", 0
=======
func checkHobby75(F_step2_50 []info.Fixinformation, myHobby info.Hobby) (int, string) {
	var step2Result []info.Fixinformation
	var step1Result75 []info.Fixinformation
	for i := 0; i < len(F_step2_50); i++ {
		if F_step2_50[i].Age >= myHobby.Era && F_step2_50[i].Age < myHobby.Era+10 && F_step2_50[i].Gender == myHobby.Gender {
			step2Result = append(step2Result, F_step2_50[i])
		}
	}
	if len(step2Result) > 3 {
		return int(step2Result[rand.Intn(len(step2Result))].UserID), "100%"
	} else {
		for i := 0; i < len(F_step2_50); i++ {
			if F_step2_50[i].Age >= myHobby.Era && F_step2_50[i].Age < myHobby.Era+10 || F_step2_50[i].Gender == myHobby.Gender {
				step1Result75 = append(step1Result75, F_step2_50[i])
			}
		}
		if len(step1Result75) > 3 {
			return int(step1Result75[rand.Intn(len(step1Result75))].UserID), "75%"
		}
	}
	return 0, "Not Found"
}

func checkHobby100(F_step2_75 []info.Fixinformation, myHobby info.Hobby) (int, string) {
	var step1Result63 []info.Fixinformation
	var step1Result75 []info.Fixinformation
	for i := 0; i < len(F_step2_75); i++ {
		if F_step2_75[i].Age >= myHobby.Era && F_step2_75[i].Age < myHobby.Era+10 && F_step2_75[i].Gender == myHobby.Gender {
			step1Result63 = append(step1Result63, F_step2_75[i])
		}
	}
	if len(step1Result63) > 3 {
		return int(step1Result63[rand.Intn(len(step1Result63))].UserID), "63%"
	} else {
		for i := 0; i < len(F_step2_75); i++ {
			if F_step2_75[i].Age >= myHobby.Era && F_step2_75[i].Age < myHobby.Era+10 || F_step2_75[i].Gender == myHobby.Gender {
				step1Result75 = append(step1Result75, F_step2_75[i])
			}
		}
		if len(step1Result75) > 3 {
			return int(step1Result75[rand.Intn(len(step1Result75))].UserID), "75%"
		}
	}
	return 0, "Not Found"
>>>>>>> 538c5dbae4fcec00a3068062aca711dbf2f2ae8a
}
