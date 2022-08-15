defmodule ChatAppWeb.ClockLive do
  use ChatAppWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    socket = assign_current_time(socket)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1 style="display: inline;
    width: 100px;
    height: 100px;
    
    padding: 5px;
    border: 1px solid blue;
    background-color: yellow;"><%= @now %></h1>
    """
  end

  def handle_info(:tick, socket) do
    socket = assign_current_time(socket)

    {:noreply, socket}
  end

  def assign_current_time(socket) do
    now =
      Time.utc_now()
      |> Time.to_string()
      |> String.split(".")
      |>hd

    assign(socket, now: now)
  end
end
