classdef defcon
    methods (Static)
        function s = one(text)
            if defcon.setLevel() <= 1
                disp(text)
                s = true;
            else
                s = false;
            end
        end
        function s = two(text)
            if defcon.setLevel() <= 2
                disp(text)
                s = true;
            else
                s = false;
            end
        end
        function s = three(text)
            if defcon.setLevel() <= 3
                disp(text)
                s = true;
            else
                s = false;
            end
        end
        function s = four(text)
            if defcon.setLevel() <= 4
                disp(text)
                s = true;
            else
                s = false;
            end
        end
        function s = five(text)
            if defcon.setLevel() <= 5
                disp(text)
                s = true;
            else
                s = false;
            end
        end
        function out = getLevel()
            out = defcon.setLevel();
        end
        function out = setLevel(val)
            persistent level;
            if nargin
                level = val;
            end
            out = level;
        end
    end
end