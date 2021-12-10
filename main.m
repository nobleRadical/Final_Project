%main script execution.
%housekeeping:
clear;clc;close all;
%{
This program (project)'s goal is to be a retirement age calculator. 
It should take some inputs, perhaps also a dataset for calculating averages, 
and then deliver an age of retirement as a scalar 
and the average range of retirement ages using a graph.
%}
defcon.setLevel(6);
% assumed variables
death_age = 90;
married = false; % overwritten if we decide to call getMarried()
%assuming no dependents
%assuming no growth rate for income or inflation

%user variables
current_age = input("Enter your age:");
current_salary = input("Enter your current yearly salary: $");
asset_expense = input("Enter your average asset expenses per year that you will be paying when retired (consistent expenses related to your car, house, etc): $");
base_spending = input("How much do you spend per month, on average (for food, commodities, etc.): $");
savings_year = input("Enter the amount added to your savings per year, on average: $");
total_savings = input("Enter your total current savings: $");
average_taxes_year = input("What is your average tax payment per year? If you get a return, enter a negative number: $");
large_future_expenses = input("Do you plan any large future expenses? If so, enter their estimated total cost here, with tax: $");
expected_pension = input("What is your expected pension payment per month: $");
min_savings = input("What is the amount of savings you would like left over when you die?: $");
% main calculations
years_left = death_age - current_age;
% amount of money spent per year during retirement
money_spending_per_year = ((base_spending .* 12) + asset_expense + average_taxes_year); 
if money_spending_per_year <= 0 % we might be able to stop here
    if (total_savings + (money_spending_per_year * yearsLeft) - large_future_expenses) >= min_savings % pension + total_savings pays for everything
        disp("Your retirement pension and total savings cover all listed expenses. You can retire at any age past your expected pension age.");
        disclaimer();
        return
    end
end
%total money had (gained plus savings) - total money needed needs to be >= min_savings
total_money_needed = (money_spending_per_year .* years_left) + large_future_expenses;
% total_money_gained + total_savings - total_money_needed = min_savings --> solve for retirementAge
retirementAge = (min_savings + total_money_needed - total_savings + (expected_pension .* 12 .* current_age)) / (expected_pension .* 12);
retirementAge = floor(retirementAge);
total_money_gained = (expected_pension .* 12 .* (retirementAge - current_age));
defcon.five(sprintf("years left: %d", years_left));
defcon.five(sprintf("total_money_needed: %d", total_money_needed));
defcon.five(sprintf("total_money_gained: %d", total_money_gained));
if retirementAge >= death_age
    disp("You may need more money than calculated here to retire.");
    disclaimer();
    return
end
fprintf("Not accounting for inflation, changes in income, or other extraneous happenings, you can retire at %d.\n\n", floor(retirementAge));
disclaimer();

% figures
figure(1)
age = [25;35;45;55;65];
retirementNumber = [26839;72578;135777;197322;216720];
clr = [1 1 0; 1 1 0; 1 1 0; 1 1 0; 1 1 0];
switch retirementAge
    case num2cell(25:34)
        clr(1,:) = [1 0 0];
        defcon.four("g1");
    case num2cell(35:44)
        clr(2,:) = [1 0 0];
        defcon.four("g2");
    case num2cell(45:54)
        clr(3,:) = [1 0 0];
        defcon.four("g3");
    case num2cell(55:64)
        clr(4,:) = [1 0 0];
        defcon.four("g4");
    case num2cell(65:91)
        clr(5,:) = [1 0 0];
        defcon.four("g5");
    otherwise
        defcon.four("None?");
end
c1 = bar(age, retirementNumber, 'facecolor', 'flat');
c1.CData = clr;
xlabel('Age')
ylabel('Average 401k Balance (from Vanguard)')
title('The Average 401k Balance by Age (in increments of 9 years')

function married = getMarried() %deprecated
    while true % loop to make the user enter an acceptable answer
    married = input("Are you married? y/n >", 's');
        if regexp(married,"[yY][eE]?[sS]?[1]?") % if yes
            married = true;
            break % leave the loop
        elseif regexp(married,"[nN][oO][0]?") % if no
            married = false;
            break % leave the loop
        else
            disp("You entered neither a yes or no for 'married'.")
        end
    end
end
function disclaimer()
    disp("Remember, this program does not and should not substitute appropriate legal or financial advice.");
end