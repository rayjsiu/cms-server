CREATE TABLE `cms`.`user_account` (
  `user_profile_id` INT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `password_salt` VARCHAR(50) NOT NULL,
  `password_hash_algo` VARCHAR(50) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email_confirmed` TINYINT NULL DEFAULT 0,
  `email_confirmation_token` VARCHAR(100) NULL,
  `user_account_status_id` INT NULL,
  `password_reminder_token` VARCHAR(100) NULL,
  `password_reminder_expire` TIMESTAMP NULL,
  PRIMARY KEY (`user_profile_id`),
  INDEX `ID` (`user_profile_id` ASC),
  UNIQUE INDEX `EMAIL_UNIQ` (`email` ASC));

CREATE TABLE `cms`.`user_profile` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(255) NULL,
  `last_name` VARCHAR(255) NULL,
  `accept_terms_of_service` TINYINT NULL,
  `time_zone` VARCHAR(100) NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `cms`.`user_account_status` (
  `id` INT NOT NULL,
  `code` VARCHAR(10) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`));

ALTER TABLE `cms`.`user_account` 
ADD INDEX `USER_ACCT_STATUS_idx` (`user_account_status_id` ASC);
ALTER TABLE `cms`.`user_account` 
ADD CONSTRAINT `USER_PROFILE`
  FOREIGN KEY (`user_profile_id`)
  REFERENCES `cms`.`user_profile` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `USER_ACCT_STATUS`
  FOREIGN KEY (`user_account_status_id`)
  REFERENCES `cms`.`user_account_status` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `cms`.`role` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `cms`.`user_role` (
  `id` INT NOT NULL,
  `user_profile_id` INT NULL,
  `role_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `ROLE_idx` (`role_id` ASC),
  INDEX `USER_PROFILE_idx` (`user_profile_id` ASC),
  CONSTRAINT `USER_PROFILE_ROLE`
    FOREIGN KEY (`user_profile_id`)
    REFERENCES `cms`.`user_profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ROLE`
    FOREIGN KEY (`role_id`)
    REFERENCES `cms`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
