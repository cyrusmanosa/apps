package db

import (
	"Backend/util"
	"context"
	"testing"

	"github.com/brianvoe/gofakeit/v6"
	"github.com/stretchr/testify/require"
)

func TestCreateUserCanChangeInformation(t *testing.T) {
	arg := CreateRandomUserFixInformaion(t)
	CreateRandomUserCanChangeInformation(t, arg)
}

func CreateRandomUserCanChangeInformation(t *testing.T, user Fixinformation) Canchangeinformation {
	Can := CreateUserCanChangeInformationParams{
		UserID:        user.UserID,
		Nickname:      gofakeit.FirstName(),
		City:          gofakeit.City(),
		Sexual:        util.RandomSexual(),
		Height:        int32(gofakeit.Number(140, 200)),
		Weight:        int32(gofakeit.Number(40, 150)),
		Speaklanguage: gofakeit.Language(),
		Education:     util.RandomEducation(),
		Job:           gofakeit.JobTitle(),
		AnnualSalary:  int32(gofakeit.Number(200, 600)),
		Sociability:   util.RandomSociability(),
		Religious:     util.RandomReligious(),
		Introduce:     gofakeit.HackerPhrase(),
	}

	CanInformation, err := testQueries.CreateUserCanChangeInformation(context.Background(), Can)
	require.NoError(t, err)
	require.NotEmpty(t, CanInformation)

	require.Equal(t, CanInformation.Nickname, Can.Nickname)
	require.Equal(t, CanInformation.City, Can.City)
	require.Equal(t, CanInformation.Sexual, Can.Sexual)
	require.Equal(t, CanInformation.Height, Can.Height)
	require.Equal(t, CanInformation.Weight, Can.Weight)
	require.Equal(t, CanInformation.Speaklanguage, Can.Speaklanguage)
	require.Equal(t, CanInformation.Education, Can.Education)
	require.Equal(t, CanInformation.Job, Can.Job)
	require.Equal(t, CanInformation.AnnualSalary, Can.AnnualSalary)
	require.Equal(t, CanInformation.Sociability, Can.Sociability)
	require.Equal(t, CanInformation.Religious, Can.Religious)
	require.Equal(t, CanInformation.Introduce, Can.Introduce)
	require.NotZero(t, CanInformation.InfoChangedAt)

	return CanInformation
}

func TestUpdateInformation(t *testing.T) {
	arg := CreateRandomUserFixInformaion(t)
	user := CreateRandomUserCanChangeInformation(t, arg)

	Can := UpdateInformationParams{
		UserID:        user.UserID,
		Nickname:      gofakeit.FirstName(),
		City:          gofakeit.City(),
		Sexual:        util.RandomSexual(),
		Height:        int32(gofakeit.Number(140, 200)),
		Weight:        int32(gofakeit.Number(40, 150)),
		Speaklanguage: gofakeit.Language(),
		Education:     util.RandomEducation(),
		Job:           gofakeit.JobTitle(),
		AnnualSalary:  int32(gofakeit.Number(200, 600)),
		Sociability:   util.RandomSociability(),
		Religious:     util.RandomReligious(),
		Introduce:     gofakeit.HackerPhrase(),
	}
	UpdateCan, err := testQueries.UpdateInformation(context.Background(), Can)
	require.NoError(t, err)
	require.NotEmpty(t, UpdateCan)
	require.Equal(t, UpdateCan.Nickname, Can.Nickname)
	require.Equal(t, UpdateCan.City, Can.City)
	require.Equal(t, UpdateCan.Sexual, Can.Sexual)
	require.Equal(t, UpdateCan.Height, Can.Height)
	require.Equal(t, UpdateCan.Weight, Can.Weight)
	require.Equal(t, UpdateCan.Speaklanguage, Can.Speaklanguage)
	require.Equal(t, UpdateCan.Education, Can.Education)
	require.Equal(t, UpdateCan.Job, Can.Job)
	require.Equal(t, UpdateCan.AnnualSalary, Can.AnnualSalary)
	require.Equal(t, UpdateCan.Sociability, Can.Sociability)
	require.Equal(t, UpdateCan.Religious, Can.Religious)
	require.Equal(t, UpdateCan.Introduce, Can.Introduce)
	require.NotEqual(t, UpdateCan.InfoChangedAt, user.InfoChangedAt)

}

func TestGetUserCanChangeInformation(t *testing.T) {
	arg := CreateRandomUserFixInformaion(t)
	user1 := CreateRandomUserCanChangeInformation(t, arg)

	GetCan, err := testQueries.GetUserCanChangeInformation(context.Background(), user1.UserID)
	require.NoError(t, err)
	require.NotEmpty(t, GetCan)

	require.Equal(t, user1.Nickname, GetCan.Nickname)
	require.Equal(t, user1.City, GetCan.City)
	require.Equal(t, user1.Sexual, GetCan.Sexual)
	require.Equal(t, user1.Height, GetCan.Height)
	require.Equal(t, user1.Weight, GetCan.Weight)
	require.Equal(t, user1.Education, GetCan.Education)
	require.Equal(t, user1.Job, GetCan.Job)
	require.Equal(t, user1.AnnualSalary, GetCan.AnnualSalary)
	require.Equal(t, user1.Sociability, GetCan.Sociability)
	require.Equal(t, user1.Religious, GetCan.Religious)
	require.Equal(t, user1.Introduce, GetCan.Introduce)
	require.Equal(t, user1.InfoChangedAt, GetCan.InfoChangedAt)
}

func TestListCanChangeInformation(t *testing.T) {
	for i := 0; i < 10; i++ {
		arg := CreateRandomUserFixInformaion(t)
		CreateRandomUserCanChangeInformation(t, arg)
	}

	ListCan, err := testQueries.ListCanChangeInformation(context.Background())
	require.NoError(t, err)
	require.NotEmpty(t, ListCan)

}

func TestDeleteInformation(t *testing.T) {
	user := CreateRandomUserFixInformaion(t)
	Can := CreateRandomUserCanChangeInformation(t, user)

	err := testQueries.DeleteInformation(context.Background(), Can.UserID)
	require.NoError(t, err)
}
