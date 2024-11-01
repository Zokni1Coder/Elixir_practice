defmodule ChatAppWeb.Live.ChartComponent do
  use ChatAppWeb, :live_component

  @backgrounds ["bg-red-400", "bg-blue-400", "bg-green-400"]

  def update(assigns, socket) do
    rnd_columns =
      if connected?(socket),
        do:
          Enum.reduce(
            1..assigns.column_num,
            %{},
            &Map.put(&2, :"col#{&1}", %{
              value: Enum.random(0..100),
              color:
                assigns |> Map.get(:"col#{&1}", %{}) |> Map.get(:color, Enum.random(@backgrounds))
            })
          ),
        else: %{}

    socket = assign(socket, assigns)
    {:ok, socket}
  end

  def render(assigns) do
    assigns = Map.put(assigns, :backgrounds, @backgrounds)

    ~H"""
    <div class="flex items-end h-52 w-full max-w-md gap-1">
      <div
        :for={column_index <- 1..@column_num}
        style={"height: #{assigns[:"col#{column_index}"]}%;"}
        class={"flex-1 #{Enum.random(@backgrounds)} rounded-t-xl transition-all"}
      >
      </div>
    </div>
    """
  end

  defp rnd(true), do: Enum.random(0..100)

  defp get_rnd_columns(column_num, connected? \\ true)

  defp get_rnd_columns(column_num, connected?) when is_integer(column_num),
    do:
      Enum.reduce(1..column_num, [], fn column_index, column_assigns ->
        column_assigns ++ [{:"col#{column_index}", rnd(connected?)}]
      end)

  defp get_rnd_columns(_column_num, _connected?), do: []
end
