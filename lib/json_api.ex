defmodule JsonApi do
  @moduledoc """
    https://jsonplaceholder.typicode.com/todos 의 JSON을 가져와서 
    "completed" 가 false인 항목들의 id 와 title을 출력하는 예제 입니다. 
  """


  defp printItems(map_list) do
    Enum.each(map_list, fn %{"id" => id, "title" => title} ->
                            IO.puts "ID:#{id} , #{title}"
                        end
            )
  end


  # status_code가 200 인 경우 
  defp bodyProc(200,body) do
    case Jason.decode(body) do
      {:ok, todos_map_list} ->
        Enum.filter(todos_map_list, fn %{"completed" => completed} -> completed == false end)
          |> printItems
      err -> 
          IO.puts "Json Decoding 실패 : #{inspect err}"
    end

  end

  # status_code가 200(성공) 이 아닌경우 
  defp bodyProc(status_code, body) do
    IO.puts "Status code가 200 이 아닙니다. : #{status_code}"
    IO.puts "Body : #{inspect body}"
  end

  @doc """
    http 접속후 JSON을 map 으로 변환한 후 , completed가 false인 항목들만 출력 
  """
  def getNotCompletedTodos do
    case HTTPoison.get "https://jsonplaceholder.typicode.com/todos" do
      {:ok,%{body: body, status_code: status_code}} ->
          bodyProc(status_code, body)
      {:error, error} ->
          IO.puts "오류 발생 : #{inspect error}"
    end      
  end
end
