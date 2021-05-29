defmodule ElixirFormulaWeb.PaginationComponent do
  @moduledoc """
  Live view pagination component.
  """
  use ElixirFormulaWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="flex flex-col items-center my-12">
      <div class="flex text-gray-700">
        <%= if @current_page > 1 do %>
          <%= live_patch to: Routes.publications_index_path(@socket, :index, page: @current_page - 1), class: "pagination-arrow mr-1" do %>
            <i class="fas fa-chevron-left"></i>
          <% end %>
        <% end %>
        <div class="flex h-12 font-medium rounded-full bg-gray-200">
          <%= for page <- (@current_page - 2)..(@current_page + 2), page > 0 && page <= @total_pages do %>
            <%= live_patch page, to: Routes.publications_index_path(@socket, :index, page: page), class: "pagination-number md:flex " <> (if page == @current_page, do: "active-page", else: "") %>
          <% end %>
        </div>
        <%= if @current_page < @total_pages do %>
          <%= live_patch to: Routes.publications_index_path(@socket, :index, page: @current_page + 1), class: "pagination-arrow ml-1" do %>
            <i class="fas fa-chevron-right"></i>
          <% end %>
        <% end %>
      </div>
    </div>
    """
  end
end
