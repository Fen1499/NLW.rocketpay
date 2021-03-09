defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase
  import Phoenix.View
  alias Rocketpay.{Account, User}

  test "render create.json" do
    params = %{
      name: "felipe",
      password: "123456",
      nickname: "fen",
      email: "fen@fen.com",
      age: 26
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Rocketpay.create_user(params)
    response = render(RocketpayWeb.UsersView, "create.json", user: user )

    expected_response = %{
      account: %{
        balance: Decimal.new("0.00"),
        id: account_id
      },
      id: user_id,
      message: "User created",
      name: "felipe",
      nickname: "fen"
    }

    assert expected_response == response
  end

end
