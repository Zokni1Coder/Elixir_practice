defmodule ChatAppWeb.ChatLive do
  use ChatAppWeb, :live_view

  alias Ecto.UUID

  def mount(_params, _session, socket) do
    socket = socket |> stream(:messages, []) |> assign(form: to_form(%{}, as: "messages"))
    {:ok, socket}
  end

  def handle_event("update-messages", %{"messages" => %{"message" => message}}, socket) do
    socket = assign(socket, form: to_form(%{"message" => message}, as: "messages"))
    {:noreply, socket}
  end

  def handle_event("message", %{"messages" => %{"message" => message}}, socket) do
    socket =
      socket
      |> stream_insert(:messages, %{
        id: UUID.generate(),
        message: message,
        time:
          DateTime.utc_now()
          |> Timex.Timezone.convert("Europe/Budapest")
          |> Timex.format!("%Y-%m-%d %H:%M:%S", :strftime)
      })
      |> assign(form: to_form(%{"message" => ""}, as: "messages"))

    # IO.inspect(socket, label: "FUUUUCK")
    {:noreply, socket}
  end
end
