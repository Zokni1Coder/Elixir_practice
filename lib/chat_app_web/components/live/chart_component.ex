defmodule ChatAppWeb.Live.ChartComponent do
  use ChatAppWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>aaasdadad <%= @content %> </div>
    """
  end

end
