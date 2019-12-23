function health_calc()

% This MATLAB project takes measurements from the user concerning age,
% gender, height, weight, and other fitness-related measurements. Using
% this data, the program calculates a person's body fat percentage, body
% mass index, basal metabolic rate, and total daily energy expenditure.
% Comparing a person's caloric intake to their suggested intake (TDEE), the
% program suggests appropriate foods or exercises to approach a target fat percentage.


%% Input Statements for User Measurements

User.Gender = input('Are you male or female? Enter (1) for male, (2) for female:\n');  % Gender (1 = male, 2 = female)
while (isempty(User.Gender) == 1) || ((User.Gender ~= 1) && (User.Gender ~= 2))     % Checks if input is empty space or of improper format
    fprintf('Please input the proper data.\n')                          % Error message
    User.Gender = input('Are you male or female? Enter (1) for male, (2) for female:\n');   %Repeats prompt
end

User.Age = input('How old are you (in years) ?\n');                     % Age in years
while (isempty(User.Age) == 1) || ((isa(User.Age,'double') == 0) || (User.Age < 1))
    fprintf('Please input a positive integer.\n')
    User.Age = input('How old are you (in years) ?\n');
end

User.Weight.Imperial = input('How much do you weigh (in pounds) ?\n');  % Weight in lbs
while (isempty(User.Weight.Imperial) == 1) || ((isa(User.Weight.Imperial,'double') == 0) || (User.Weight.Imperial < 1))
    fprintf('Please input a positive integer.\n')
    User.Weight.Imperial = input('How much do you weigh (in pounds) ?\n');
end
User.Weight.Metric = User.Weight.Imperial * 0.453592;                 % Weight in kg

User.Height = input('How tall are you (in inches) ?\n');                % Height in inches
while (isempty(User.Height) == 1) || ((isa(User.Height,'double') == 0) || (User.Height < 1))
    fprintf('Please input a positive integer.\n')
    User.Height = input('How tall are you (in inches) ?\n');
end

User.Measurement.Waist = input('What is your waist size (in inches) ?\n'); % Waist measurement in inches
while (isempty(User.Measurement.Waist) == 1) || ((isa(User.Measurement.Waist,'double') == 0) || (User.Measurement.Waist < 1))
    fprintf('Please input a positive integer.\n')
    User.Measurement.Waist = input('What is your waist size (in inches) ?\n');
end

if User.Gender == 2                                                   % Additional measurements only required for women
    User.Measurement.Wrists = input('What is the circumference of your wrist (in inches) ?\n');
    while (isempty(User.Measurement.Wrists) == 1) || ((isa(User.Measurement.Wrists,'double') == 0) || (User.Measurement.Wrists < 1))
        fprintf('Please input a positive integer.\n')
        User.Measurement.Wrists = input('What is the circumference of your wrist (in inches) ?\n');
    end
    
    User.Measurement.Forearm = input('What is the circumference of your forearm (at the fullest point, in inches)?\n');
    while (isempty(User.Measurement.Forearm) == 1) || ((isa(User.Measurement.Forearm,'double') == 0) || (User.Measurement.Forearm < 1))
        fprintf('Please input a positive integer.\n')
        User.Measurement.Forearm = input('What is the circumference of your forearm (at the fullest point, in inches)?\n');
    end
    
    User.Measurement.Hips = input('What is the circumference of your hips (in inches) ?\n');
    while (isempty(User.Measurement.Hips) == 1) || ((isa(User.Measurement.Hips,'double') == 0) || (User.Measurement.Hips < 1))
        fprintf('Please input a positive integer.\n')
        User.Measurement.Hips = input('What is the circumference of your hips (in inches) ?\n');
    end
end

exerRate = input ('How many days do you exercise, per week (on average)?\n');
while (isempty(exerRate) == 1) || ((isa(exerRate,'double') == 0) || ((exerRate < 0) || (exerRate > 7)))
    fprintf('Please input a positive integer.\n')
    exerRate = input('How many days do you exercise, per week (on average)?\n');
end

User.Calorie = input('Approximately how many calories do you consume per day?\n'); % Caloric Intake
while (isempty(User.Calorie) == 1) || ((isa(User.Calorie,'double') == 0) || (User.Calorie < 1))
    fprintf('Please input a positive integer.\n')
    User.Calorie = input('Approximately how many calories do you consume per day?\n');
end

%% Calculations

% Calculation of Body Fat Percentage
if User.Gender == 1                                          % Calculations differ based on gender
    MFactor1 = (User.Weight.Imperial*1.082) + 94.42;
    MFactor2 = (User.Measurement.Waist*4.15);
    LeanBodyMass = MFactor1-MFactor2;
    BodyFatWeightMen = User.Weight.Imperial-LeanBodyMass;
    BFP = (BodyFatWeightMen*100)/User.Weight.Imperial;
else
    WFactor1 = (User.Weight.Imperial*0.732) + 8.987;
    WFactor2 = User.Measurement.Wrists  / 3.140;
    WFactor3 = User.Measurement.Waist   * 0.157;
    WFactor4 = User.Measurement.Hips    * 0.249;
    WFactor5 = User.Measurement.Forearm * 0.434;
    LeanBodyMassWomen = WFactor1 + WFactor2 - WFactor3 - WFactor4 + WFactor5;
    BodyFatWeightWomen = User.Weight.Imperial - LeanBodyMassWomen;
    BFP = (BodyFatWeightWomen*100) / User.Weight.Imperial;   
end

% Calculation of Body Mass Index
BMI =((User.Weight.Imperial)/(User.Height^2))*703;

% Calculation of Basal Metabolic Rate
if User.Gender == 1
    BMR = 66 + (6.23*User.Weight.Imperial)+(12.7*User.Height)-(6.8*User.Age); 
elseif User.Gender == 2
    BMR= 655 + (4.35*User.Weight.Imperial)+(4.7*User.Height)-(4.7*User.Age);
end

% Calculate of Total Daily Energy Expenditure
if exerRate <1             % Exercise Rate is used to determine scalar multiple of BMR to calculate TDEE.
    ActivityRating = 1;    % exerRate, which is measured in days of the week, is converted to Activity Rating Scale 1-5 for convenience later in the program.
    TDEE= 1.2*BMR;
elseif exerRate <3
    ActivityRating = 2;
    TDEE= 1.375*BMR;
elseif exerRate <5
    ActivityRating = 3;
    TDEE= 1.55*BMR;
elseif exerRate <7
    ActivityRating = 4;
    TDEE= 1.725*BMR;
else
    ActivityRating = 5;
    TDEE= 1.9*BMR;
end

%% Displaying these values to the user

fprintf('Your current body fat percentage (BFP) is %.2f%%.\n',BFP)
fprintf('Your body mass index (BMI) is calculated to be %.1f. \n', BMI)
fprintf('Your basal metabolic rate (BMR) is calculated to be %.2f. \n', BMR)
fprintf('Your total daily energy expenditure (TDEE) is calculated to be %.0f. \n\n', TDEE)

%% Establishing ideal values for body fat

switch User.Gender
        case 1 %Male
            if (User.Age < 25)
                BFP_ideal = 12.5;
            elseif (User.Age < 35)
                BFP_ideal = 15.5;
            elseif (User.Age < 45)
                BFP_ideal = 18;
            elseif (User.Age < 55)
                BFP_ideal = 22;
            else
                BFP_ideal = 31;
            end
        case 2   %Female
            if (User.Age < 25)
                BFP_ideal = 21.5;
            elseif (User.Age < 35)
                BFP_ideal = 23.5;
            elseif (User.Age < 45)
                BFP_ideal = 25.5;
            elseif (User.Age < 55)
                BFP_ideal = 27.5;
            else
                BFP_ideal = 31;
            end
end

currentFat = (BFP/100)*(User.Weight.Imperial); % The weight of fat in a person is calculated
idealFat = (BFP_ideal/100)*User.Weight.Imperial; % The ideal body fat weight in a person is calculated
fatLoss = currentFat - idealFat;
EnergyDifference = abs(User.Calorie - TDEE); % The energy difference is either an energy deficit (EnergyDifference<TDEE) or overeating (EnergyDifference>TDEE)
    
%% Import exercise data

%Physical Activity File has 127 rows (plus one header row), and 3 columns.
%First Column is MET value (Metabolic Equivalence Value = Calories/kg*hour)
%Second Column is Category of Exercise
%Third Column is Specific Activity

ExerciseData = readtable('ExerciseData.csv','Format','%.1f%q%q');

if (ActivityRating < 3) %Sorting suggested exercises based on previous physical activity.
    IndexE = randi([1,37]); %From the "low activity" rows, a random exercise is chosen.
    exerTime = randi([7,14]);
elseif (ActivityRating == 3)
    IndexE = randi([38,78]); % Random exercise selected from "moderate" activity rows.
    exerTime = randi([14,21]);
else
    IndexE = randi([79,127]); % Random exercise chosen from "intense" activity rows.
    exerTime = randi([21,28]);
end

MET = ExerciseData{IndexE,1}; % MET relates calorie burn to activity
CategoryE = ExerciseData{IndexE,2};
DescriptionE = ExerciseData{IndexE,3};

%% Determinations based on overnourishment/malnourishment

if (User.Calorie < TDEE)
    fprintf('You are in good physical condition. Keep it up!\n');
    actualLoss = (EnergyDifference/3500) * 7; %Fat Loss per Week. It takes a deficit of 3500 Calories to lose one pound.
    WeightLossWeeks = ceil(fatLoss/actualLoss); %Number of Weeks required to reach Fat Loss Goal
    if (WeightLossWeeks > 0)
        fprintf('With your current metabolism and exercise regimen, you will reach an ideal body fat percentage in %i weeks.\n', WeightLossWeeks)
    end
else     
    calorieBurn = MET*User.Weight.Metric*exerTime; %Calories burned per week
    fprintf('Your caloric intake exceeds your body''s required energy intake by %.0f calories.\n', EnergyDifference)
    fprintf('To help reduce caloric intake, try adding %s to your schedule. \n', char(CategoryE))
    fprintf('Consider engaging in an exercise such as %s.\n', char(DescriptionE))
    fprintf('Exercising for %i hours per week can reduce caloric intake by up to %.0f calories daily.\n\n',exerTime, calorieBurn/7)
end   

%% Food Suggestions

FoodData = readtable('FoodData.csv','Format','%q%.0f%.3f%.0f');

IndexHF = randi([1,3961]); %Row 3961 - 200 Calorie Division for Foods
IndexFF = randi([3962,7808]);

DescriptionHF = FoodData{IndexHF,1}; % MET relates calorie burn to activity
calorieHF = FoodData{IndexHF,2};
DescriptionFF = FoodData{IndexFF,1};
calorieFF = FoodData{IndexFF,2};

if (User.Calorie > TDEE)
  calorieDiet = (calorieFF - calorieHF)/7; %Calories saved by substituting fatty foods for healthy foods weekly.
  fprintf('Consider changing your diet, by replacing a fatty food, %s with a healthier alternative, %s.\n', char(DescriptionFF),char(DescriptionHF))
  fprintf('Making such a change would reduce caloric intake by %.0f calories daily.\n', calorieDiet)
end

%% Graphs

timedata=xlsread('timedata.xlsx');   % Loads data from spreadsheet into table

timedata=[timedata;BMI,BMR,TDEE];    % Adds current data to timedata file
xlswrite('timedata.xlsx',timedata);

% Graph for BMI
figure
subplot(2,2,1);
plot(timedata(:,1),'r')
title ('BMI');
ylabel ('BMI');
xlabel ('Number of times');

% Graph for BMR
subplot(2,2,2);
plot(timedata(:,2),'k')
title ('BMR');        
ylabel ('BMR,(Calories)');
xlabel ('Number of times');

% Graph for TDEE
subplot(2,2,[3,4]);
plot(timedata(:,3),'b')
title ('TDEE');        
ylabel ('TDEE,(Calories)');
xlabel ('Number of times');

end
 