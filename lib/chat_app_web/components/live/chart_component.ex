defmodule ChatAppWeb.Live.ChartComponent do
  use ChatAppWeb, :live_component

  @backgrounds ["bg-red-400", "bg-blue-400", "bg-green-400"]
  @interval 2000

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

    assigns = Map.merge(assigns, rnd_columns)
    send_update_after(__MODULE__, assigns, @interval)
    socket = assign(socket, assigns)
    {:ok, socket}
  end

  # assigns:
  #   column_num:
  #   rnd_columns: %{col1: %{value:22, color: blue @background}, col2: %{value:15, color: rand @background}, col3: %{value:25, color: rand @background}}

  def render(assigns) do
    ~H"""
    <div>
      <span class="text-center block text-sm text-gray-600"><%= @content %></span>
      <div class="flex items-end h-52 flex-1 gap-1 border-l-2 border-b-2 px-4 border-gray-400">
        <%= for column_index <- 1..@column_num do %>
          <% column_data = Map.get(assigns, :"col#{column_index}", %{}) %>
          <% height_value = Map.get(column_data, :value) %>
          <div
            style={"height: #{height_value || 0}%;"}
            class={"flex-1 #{Map.get(column_data, :color)} rounded-t-xl transition-all duration-1000 flex justify-center items-start py-1 min-w-10"}
          >
            <span class="bg-white rounded px-2 bg-opacity-50 text-gray-600 text-xs">
              <%= height_value %>
            </span>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
