class CommentsController < ApplicationController
	before_action :set_comment, only: %i[index show create update destroy]

	def index
		render json: @comment
	end

	def show
		render json: @comment
	end

	def create
		comment = @post.comments.create(comment_params)
		if comment.save
			render json: comment, status: :created
		else
			render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		if @comment.update(comment_params)
			render json: { message: "Comment ##{@comment.id} was successfully updated" }
		else 
			render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		@comment.destroy
		render json: { message: 'Post was successfully deleted' }
		head :no_content
	end

	private 

	def set_comment
		@post = Post.find(params[:post_id])
		@comment = params[:id] ? @post.comments.find(params[:id]) : @post.comments 
	end

	def comment_params
		params.require(:comment).permit(:text)
	end
end
