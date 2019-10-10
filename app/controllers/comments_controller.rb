class CommentsController < ApplicationController
    def index
        @comments = User.joins(:comments)
        .where("comments.created_at > ?", 7.days.ago)
        .group("users.name")
        .order(Arel.sql("count(comments.id) desc"))
        .count("comments.id")
        .first(10)
      end
  
      def create
          comment = current_user.comments.new(comment_params)
  
          if comment.save
              redirect_back fallback_location: root_path, notice: "Comment added OK"
          else
              redirect_back fallback_location: root_path, alert: comment_errors(comment) 
          end
      end
  
      def destroy
          comment = Comment.find(params[:id])
  
          if current_user == comment.user
              comment.destroy
              redirect_back fallback_location: root_path, notice: "Comment has been removed"
          else
              redirect_back fallback_location: root_path, alert: "You can't remove other user's comments" 
          end
      end
  
      private
  
      def comment_params
          params.require(:comment).permit(:comment, :movie_id)
      end
  
      def comment_errors(comment)
          comment.errors.full_messages.to_sentence
      end
end
