defmodule ChatAppWeb.Live.ChartComponent do
  use ChatAppWeb, :live_component

  @backgrounds ["bg-red-400", "bg-blue-400", "bg-green-400"]

  def mount(socket) do
    # socket = assign(socket, get_rnd_columns(socket.assigns[:column_num], connected?(socket)))
    {:ok, socket}
  end

  def update(assigns, socket) do
    send_update_after(
      __MODULE__,
      get_rnd_columns(socket.assigns[:column_num]) ++ [id: "chart_live_component1"],
      1000
    )

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

  defp rnd(_connected?), do: 0

  defp get_rnd_columns(column_num, connected? \\ true)

  defp get_rnd_columns(column_num, connected?) when is_integer(column_num),
    do:
      Enum.reduce(1..column_num, [], fn column_index, column_assigns ->
        column_assigns ++ [{:"col#{column_index}", rnd(connected?)}]
      end)

  defp get_rnd_columns(_column_num, _connected?), do: []
end
