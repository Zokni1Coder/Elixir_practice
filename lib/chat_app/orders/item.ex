defmodule ChatApp.Orders.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChatApp.Orders.Item

  embedded_schema do
    field :name, :string
    field :price, :float
    field :quantity, :integer
  end

  @doc false
  def changeset(%Item{} = item, attrs) do
    item
    |> cast(attrs, [:name, :price, :quantity])
    |> validate_required([:name, :price, :quantity])
  end
end
