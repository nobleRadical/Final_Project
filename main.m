%main script execution.
%housekeeping:
clear;clc;close all;
%{
This program (project)'s goal is to be a retirement age calculator. 
It should take some inputs, perhaps also a dataset for calculating averages, 
and then deliver an age of retirement as a scalar 
and the average range of retirement ages using a graph.
%}
% REMOVE THIS NEXT LINE AT RELEASE.
defcon.setLevel(4);

% assumed variables
death_age = 90;
married = false; % overwritten if we decide to call getMarried()
num_dependents = 0; %overwrittem if we decide to count dependents seperately from other things
dependent_cost = 0; % 'kid'-type dependent assumed. UNUSED
%assuming no growth rate for income or inflation
%user variables
current_age = input("Enter your age:");
current_salary = input("Enter your current yearly salary:");
asset_expense = input("Enter your average asset expenses per month that you will be paying when retired (consistent expenses related to your car, house, etc:");
base_spending = input("How much do you spend per month, on average (for food, commodities, etc.");
savings_year = input("Enter the amount added to your savings per year, on average:");
total_savings = input("Enter your total current savings:");
average_taxes_year = input("What is your average tax payment per year? If you get a return, enter a negative number:");
large_future_expenses = input("Do you plan any large future expenses? If so, enter their estimated total cost here, with tax:");
% num_dependents = input("How many dependents do you have/will have when you retire:");
% monthly_deductions = input("What is the total value of any yearly deductions:");
expected_pension = input("What is your expected pension payment per month:");
min_savings = input("What is the amount of savings you would like left over when you die?:");
% main calculations
years_left = death_age - current_age;
% amount of money spent per year during retirement
money_spending_per_year = (salary_expenses + ((base_spending + asset_expense) .* 12) + average_taxes_year); 
if money_spending_per_year <= 0 % we might be able to stop here
    if (total_savings + (money_spending_per_year * yearsLeft) - large_future_expenses) >= min_savings % pension + total_savings pays for everything
        disp("Your retirement pension and total savings cover all listed expenses. You can retire at any age past your expected pension age.");
        disclaimer();
        return
    end
end
%total money had (gained plus savings) - total money needed needs to be >= min_savings
total_money_needed = (money_spending_per_year .* years_left) + large_future_expenses;
% total_money_gained = (expected_pension .* 12 .* (retirementAge - current_age))
% total_money_gained + total_savings - total_money_needed = min_savings --> solve for retirementAge
retirementAge = (min_savings + total_money_needed - total_savings + (expected_pension .* 12 .* current_age)) / (expected_pension .* 12)
fprintf("Not accounting for inflation, changes in income, or other extraneous happenings, you can retire at %d.\n", retirementAge);
disclaimer();
return

function married = getMarried()
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