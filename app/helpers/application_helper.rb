module ApplicationHelper
    def review_count_label(reviews)
        if reviews.count == 0
          "This workout has no reviews."
        elsif reviews.count == 1
          "1 review"
        else
          "#{reviews.count} reviews"
        end
    end
end

