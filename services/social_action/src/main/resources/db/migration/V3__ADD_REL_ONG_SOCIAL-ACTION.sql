
ALTER  TABLE social_action
ADD constraint  FK_SocialActionOng
FOREIGN KEY (ong_id)  REFERENCES  ong(id);