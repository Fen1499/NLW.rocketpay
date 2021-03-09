defmodule RocketpayWeb.AccountsControllerTest  do
  use RocketpayWeb.ConnCase
  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "felipe",
        password: "123456",
        nickname: "fen",
        email: "fen@fen.com",
        age: 26
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)
      conn = put_req_header(conn, "authorization", "Basic ZGFmdDpwdW5r")
      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}
      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:ok)

      assert %{
        "account" => %{"balance" => "50.00", "id" => _id},
        "message" => "Balance changed succesfully"
      } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "AAAAA"}
      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:bad_request)

      expect_response = %{"message" => "Invalid deposit value!"}

      assert response == expect_response
    end
  end
end
