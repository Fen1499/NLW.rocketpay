defmodule Rocketpay do
  alias Rocketpay.User.Create, as: UserCreate
  alias Rocketpay.Account.Deposit, as: Deposit
  alias Rocketpay.Account.Withdraw, as: Withdraw
  alias Rocketpay.Account.Transaction, as: Transaction

 defdelegate create_user(params), to: UserCreate, as: :call

 defdelegate deposit(params), to: Deposit, as: :call
 defdelegate withdraw(params), to: Withdraw, as: :call
 defdelegate transaction(params), to: Transaction, as: :call


end
