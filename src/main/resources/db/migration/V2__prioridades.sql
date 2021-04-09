USE `politics` ;
ALTER TABLE `candidate`
ADD COLUMN `prioridades` INT(1)
DEFAULT 1;