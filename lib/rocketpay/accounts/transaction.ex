defmodule Rocketpay.Account.Transaction do

  alias Ecto.Multi
  alias Rocketpay.Repo
  alias Rocketpay.Account.Operation
  alias Rocketpay.Account.Transactions.Response, as: TransactionResponse


  def call(%{"from" => from_id, "to" => to_id, "value" => value}) do
    withdraw_params = build_params(from_id, value)
    deposit_params = build_params(to_id, value)

    Multi.new()
    |> Multi.merge(fn _changes -> Operation.call(withdraw_params, :withdraw) end)
    |> Multi.merge(fn _changes -> Operation.call(deposit_params, :deposit) end)
    |> run_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{deposit: to_account, withdraw: from_account}} ->
        {:ok, TransactionResponse.build(to_account, from_account)}
    end
  end

  #defp run_transaction(multi) do
  #  case Repo.transaction(multi) do
  #    {:error, _operation, reason, _changes} -> {:error, reason}
  #    {:ok, %{account: account}} -> {:ok, account}
  #  end
  #end
end
