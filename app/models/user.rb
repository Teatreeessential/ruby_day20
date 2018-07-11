class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         has_many   :admissions
         has_many   :chat_rooms, through: :admissions # admission을 통해서 채팅룸 여러개를 가질 수 있다.
         has_many   :chatchats  # 여러개의 채팅을 가질 수 있다.
         
    def joined_room?(room)
      self.chat_rooms.include?(room)#true or false
    end
end
