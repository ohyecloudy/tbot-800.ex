defmodule Tbot800.Twitter.DefaultImpl do
  alias Tbot800.Twitter.OAuth

  @behaviour Tbot800.Twitter.Impl

  @spec tweet(OAuth.t(), String.t()) :: :ok
  def tweet(oauth, content) do
    # twitter 계정을 여러개 사용할 수 있어야 한다.
    # 프로세스 별 oauth 설정을 가질 수 있어서 task를 사용
    Task.async(fn ->
      ExTwitter.configure(
        :process,
        Map.to_list(oauth)
      )

      ExTwitter.update(content)
    end)
    |> Task.await()

    :ok
  end
end
