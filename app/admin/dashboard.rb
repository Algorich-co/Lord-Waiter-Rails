ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Restaurants" do
          ul do
            Restaurant.order("created_at desc").limit(5).map do |restaurant|
              li link_to(restaurant.name, admin_restaurant_path(restaurant))
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to LordWaiter"
        end
      end
    end

    columns do
        column do
                panel "Recent Categories" do
                  ul do
                    Category.order("created_at desc").limit(5).map do |category|
                      li link_to(category.name, admin_restaurant_category_path(category.restaurant, category))
                    end
                  end
                end
         end
         column do
                panel "Recent Food Items" do
                  ul do
                    FoodItem.order("created_at desc").limit(5).map do |foodItem|
                      li link_to(foodItem.title, admin_category_food_item_path(foodItem.category, foodItem))
                    end
                  end
                end
         end
    end



  end # content
end
