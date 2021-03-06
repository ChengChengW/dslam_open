% Copyright (C) 2017-2018 Titus Cieslewski, RPG, University of Zurich, 
%   Switzerland
%   You can contact the author at <titus at ifi dot uzh dot ch>
% Copyright (C) 2017-2018 Siddharth Choudhary, College of Computing,
%   Georgia Institute of Technology, Atlanta, GA, USA
% Copyright (C) 2017-2018 Davide Scaramuzza, RPG, University of Zurich, 
%   Switzerland
%
% This file is part of dslam_open.
%
% dslam_open is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% dslam_open is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with dslam_open. If not, see <http://www.gnu.org/licenses/>.

function between_robot_links = ...
    countBetweenRobotLinks(decentr_state, group_reindexing)

nr_robots = numel(decentr_state);
between_robot_links = zeros(nr_robots);

for robot_i = 1:nr_robots
    robot_state = decentr_state{robot_i};
    
    for match_i = 1:numel(robot_state.place_matches)
        place_match = robot_state.place_matches{match_i};
        
        if isempty(place_match) || group_reindexing(place_match.robot_i) <= robot_i
            continue;
        end
        
        matched_robot = group_reindexing(place_match.robot_i);
        assert(any(...
            decentr_state{robot_i}.grouped_with == place_match.robot_i));
        
        between_robot_links(robot_i, matched_robot) = ...
            between_robot_links(robot_i, matched_robot) + 1;
    end
end

end

