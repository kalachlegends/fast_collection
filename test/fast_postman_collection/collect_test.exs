defmodule FastPostmanCollection.CollectTest do
  alias FastPostmanCollection.CollectDataModuleParams
  use ExUnit.Case

  setup do
    Application.put_env(:fast_postman_collection, :router, TestAppWeb.Router)
  end

  test "Not found phoenix router in FastPostmanCollection.Collect.generate_data_by_router/0" do
    Application.delete_env(:fast_postman_collection, :router)

    assert %FastPostmanCollection.Expectation.PhoenixRouterNotFound{message: message} =
             catch_error(FastPostmanCollection.Collect.generate_data_by_router())

    assert message =~
             "Not found phoenix router in config or function"
  end

  test "collect FastPostmanCollection.generate_data_by_router/0" do
    data = FastPostmanCollection.Collect.generate_data_by_router()

    assert is_list(data)
    user_controller_item = Enum.find(data, fn x -> x.module == TestAppWeb.UserController end)

    assert %{
             doc_params: %CollectDataModuleParams{folder_path: nil, filter: "test"},
             functions: functions
           } = user_controller_item

    assert is_list(functions)
    functions_item = Enum.find(functions, fn x -> x.name == :index end)
    assert %{doc_params: %{params: %{}}, documentation: documentation} = functions_item
    assert documentation =~ "This route index"
  end

  test "FastPostmanCollection.get_from_map(map)" do
    assert %FastPostmanCollection.CollectDataItemParams{mode: "raw"} =
             FastPostmanCollection.CollectDataItemParams.get_from_map(%{mode: "raw"})
  end
end
