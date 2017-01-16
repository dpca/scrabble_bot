defmodule ScrabbleBot.Slack do
  @moduledoc """
  Handles interaction with slack real time messaging
  """

  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    case ScrabbleBot.tally(message.text) do
      x when x == 1 ->
        send_message("Woohoo! You scored #{x} point!", message.channel, slack)
      x when x > 1 ->
        send_message("Woohoo! You scored #{x} points!", message.channel, slack)
      _ ->
        IO.puts "Got message '#{message.text}', no points"
    end
    {:ok, state}
  end
  def handle_event(_, _, state), do: {:ok, state}
end
