class FollowRequestsController < ApplicationController
  
    def create
      @receiver = User.find(params[:receiver_id])
      @request = current_user.sent_follow_requests.build(receiver: @receiver, status: "pending")
  
      if @request.save
        redirect_to profile_path(@receiver.profile), notice: "Already sent"
      else
        redirect_to profile_path(@receiver.profile), alert: "Cannot send"
      end
    end
  
    def update
      @request = current_user.received_follow_requests.find(params[:id])
  
      if params[:accept]
        @request.update(status: "accepted")
        notice = "Accepted"
      elsif params[:reject]
        @request.update(status: "rejected")
        notice = "Denied"
      end
  
      redirect_to profile_path(current_user.profile), notice: notice
    end
  
    def destroy
      @request = current_user.sent_follow_requests.find(params[:id])
      @request.destroy
      redirect_to profile_path(@request.receiver.profile), notice: "Request canceled"
    end
  end
  
