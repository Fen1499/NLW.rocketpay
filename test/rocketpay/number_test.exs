defmodule Rocketpay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "Quando existe um arquivo" do
      response = Numbers.sum_from_file("numbers")

      expected_response = {:ok, %{result: 37}}

      assert response == expected_response
    end

    test "Quando n existe um arquivo" do
      response = Numbers.sum_from_file("numbrs")

      expected_response = {:error, %{message: "Invalid File"}}

      assert response == expected_response
    end
  end
end
