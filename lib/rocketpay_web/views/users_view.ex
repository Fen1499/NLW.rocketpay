defmodule RocketpayWeb.UsersView do

  alias Rocketpay.{Account, User}

  def render("create.json", %{
    user: %User{
      id: id,
      name: name,
      nickname: nickname,
      account: %{id: account_id, balance: balance}
      }
    }) do
    %{
      message: "User created",
      id: id,
      name: name,
      nickname: nickname,
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end
end
