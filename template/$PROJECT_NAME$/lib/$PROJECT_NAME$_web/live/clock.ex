defmodule <%= @project_name_camel_case %>Web.Clock do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div>
      <h2><%%= @date %></h2>
    </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    {:ok, put_date(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, put_date(socket)}
  end

  defp put_date(socket) do
    {{y, m, d}, {h, min, sec}} = :calendar.local_time()
    assign(socket, date: "#{y}-#{m}-#{d} #{h}:#{min}:#{sec}")
  end
end
