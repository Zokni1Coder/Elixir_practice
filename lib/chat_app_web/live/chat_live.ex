defmodule ChatAppWeb.ChatLive do
  use ChatAppWeb, :live_view

  alias Ecto.UUID
  alias ChatAppWeb.Endpoint

  @chat_topic "chat"

  def mount(_params, _session, socket) do
    if connected?(socket), do: Endpoint.subscribe(@chat_topic)
    socket = socket |> stream(:messages, []) |> assign(form: to_form(%{}, as: "messages"), no_messages?: true)
    {:ok, socket}
  end

  def handle_event("update-messages", %{"messages" => %{"message" => message}}, socket) do
    socket = assign(socket, form: to_form(%{"message" => message}, as: "messages"))
    {:noreply, socket}
  end

  def handle_event("message", %{"messages" => %{"message" => ""}}, socket) , do: {:noreply, socket}

  def handle_event("message", %{"messages" => %{"message" => message}}, socket) do
    socket = assign(socket, form: to_form(%{"message" => ""}, as: "messages"))

    Endpoint.broadcast(@chat_topic, "message", message)
    # IO.inspect(socket, label: "FUUUUCK")
    {:noreply, socket}
  end

  def handle_info(%{topic: @chat_topic, event: "message", payload: message}, socket) do
    socket =
      socket
      |> stream_insert(:messages, %{
        id: UUID.generate(),
        message: message,
        time:
          DateTime.utc_now()
          |> Timex.Timezone.convert("Europe/Budapest")
          |> Timex.format!("%Y-%m-%d %H:%M:%S", :strftime)
      }) |> assign(no_messages?: false)
      {:noreply, socket}
  end
end
