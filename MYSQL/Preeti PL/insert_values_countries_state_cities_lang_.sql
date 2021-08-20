INSERT INTO countries (CountryID,CountryName) VALUES (1, 'India'), (2, 'Canada'), (3, 'Japan'), (4, 'United States'), (5, 'United Kingdom'), (6, 'Germany'), (7, 'Ireland'), (8, 'South Korea'), (9, 'Mexico'), (10, 'Italy');

INSERT INTO states (StateID,StateName, CountryID) VALUES ('1', 'Punjab', '1'), ('2', 'Gujarat', '1'), ('3', 'Gangwon', '8'), ('4', 'Tokyo', '3'), ('5', 'California', '4'), ('6', 'London', '5'), ('7', 'Trentino', '10'), ('8', 'Alberta', '2'), ('9', 'Jalisco', '9'), ('10', 'Munster', '7');


INSERT INTO `cities` (`CityID`, `CityName`, `StateID`) VALUES ('1', 'Amritsar', '1'), ('2', 'Ahmedabad', '2'), ('3', 'Wonsan', '3'), ('4', 'Shibuya', '4'), ('5', 'Los Angeles', '5'), ('6', 'Islington', '6'), ('7', 'Arco', '7'), ('8', 'Calgary', '8'), ('9', 'San Sebastian', '9'), ('10', 'Waterford', '10');

INSERT INTO `languages` (`LanguageID`, `LanguageName`) VALUES ('1', 'English'), ('2', 'Hindi'), ('3', 'Punjabi'), ('4', 'Gujarati'), ('5', 'Korean'), ('6', 'French'), ('7', 'Spanish'), ('8', 'Tamil'), ('9', 'Malayalam'), ('10', 'Telugu');