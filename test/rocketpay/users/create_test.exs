defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase
  alias Rocketpay.User.Create
  alias Rocketpay.User

  describe "call\1" do
    test "when all params are valid returns an user" do
      params = %{
        name: "felipe",
        password: "123456",
        nickname: "fen",
        email: "fen@fen.com",
        age: 26
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "felipe", age: 27, id: ^user_id} = user
    end

    test "when there are invalid params returns an error" do
      params = %{
        name: "felipe",
        password: "12345",
        nickname: "fen",
        email: "fen@fen.com",
        age: 2
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
