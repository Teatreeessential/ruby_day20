class Admission < ApplicationRecord
    # 양쪽에 걸침
    belongs_to  :user       # 캐시 지정 true : 자동으로 업데이트가 됨.    
    belongs_to  :chat_room, counter_cache: true  
    
    after_commit :user_joined_chat_room_notification, on: :create
    after_commit :user_exit_chat_room_notification, on: :destroy
    
    def user_joined_chat_room_notification
        Pusher.trigger("chat_room_#{self.chat_room_id}",'join',self.as_json.merge({email:self.user.email}))
        Pusher.trigger("chat_room",'join',self.as_json.merge({email:self.user.email}))
    end
    
    def user_exit_chat_room_notification
         Pusher.trigger("chat_room_#{self.chat_room_id}",'exit',self.as_json.merge({email:self.user.email}))
         Pusher.trigger("chat_room",'exit',self.as_json.merge({email:self.user.email}))
         Pusher.trigger("chat_room_#{self.chat_room_id}",'disaster',self.as_json.merge({email:self.user.email}))
         Pusher.trigger("chat_room",'disaster',self.as_json.merge({email:self.user.email}))
    end
end
