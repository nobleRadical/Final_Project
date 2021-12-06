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
defcon.setLevel(5);

age = input("Enter your age:");
current_salary = input("Enter your current salary:");
salary_expenses = input("Enter your salary expenses (Things that come out of your salary consistently):");
savings_year = input("Enter your savings earned per year:");
total_savings = input("Enter your total current savings:");
asset_expense = input("Enter your asset expenses (consistent expenses related to your car, house, etc:");
average_taxes_year = input("What is your average tax payment per year? If you get a return, enter a negative number:");
large_future_expenses = input("Do you plan any large future expenses? If so, enter their estimated total cost here:");
num_dependents = input("How many dependents do you have/will have:");
while true %loop to make the use actually enter an acceptable answer
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
monthly_deductions = input("What is the total value of any monthly deductions, per month:");
expected_pension = input("What is your expected pension:");

