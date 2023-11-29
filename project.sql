 -- User Table 생성
CREATE TABLE IF NOT EXISTS `user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` VARCHAR(50) NOT NULL,
  `profile_info` TEXT,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)
) ENGINE=InnoDB;

-- DesignRequest Table 생성
CREATE TABLE IF NOT EXISTS `design_request` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `customer_id` BIGINT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `category` VARCHAR(100) NOT NULL,
  `budget` DECIMAL(10,2) NOT NULL,
  `deadline` DATE NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_idx` (`customer_id` ASC),
  CONSTRAINT `fk_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- Proposal Table 생성
CREATE TABLE IF NOT EXISTS `proposal` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `design_request_id` BIGINT NOT NULL,
  `designer_id` BIGINT NOT NULL,
  `proposal_text` TEXT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_design_request_idx` (`design_request_id` ASC),
  INDEX `fk_designer_idx` (`designer_id` ASC),
  CONSTRAINT `fk_design_request`
    FOREIGN KEY (`design_request_id`)
    REFERENCES `design_request` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_designer`
    FOREIGN KEY (`designer_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- Portfolio Table 생성
CREATE TABLE IF NOT EXISTS `portfolio` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `designer_id` BIGINT NOT NULL,
  `link` VARCHAR(255) NOT NULL,
  `description` TEXT,
  PRIMARY KEY (`id`),
  INDEX `fk_designer_portfolio_idx` (`designer_id` ASC),
  CONSTRAINT `fk_designer_portfolio`
    FOREIGN KEY (`designer_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- Review Table 생성
CREATE TABLE IF NOT EXISTS `review` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `design_request_id` BIGINT NOT NULL,
  `customer_id` BIGINT NOT NULL,
  `rating` INT NOT NULL,
  `comment` TEXT,
  PRIMARY KEY (`id`),
  INDEX `fk_design_request_review_idx` (`design_request_id` ASC),
  INDEX `fk_customer_review_idx` (`customer_id` ASC),
  CONSTRAINT `fk_design_request_review`
    FOREIGN KEY (`design_request_id`)
    REFERENCES `design_request` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_review`
    FOREIGN KEY (`customer_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;
