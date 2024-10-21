defmodule ChatApp.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChatApp.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        customer: "some customer",
        items: "some items",
        name: "some name",
        price: 120.5,
        status: :draft
      })
      |> ChatApp.Orders.create_order()

    order
  end
end
