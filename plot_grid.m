function [ map ] = plot_grid( map, pos, bump )
% plot the current location, update the map

% robot size
robit_size = 0.3;
% assume the map is square
len = length(map);
% how long to draw the direction vector
vect_len = 0.2;

disp(pos)

%map_size = robit_size*len;
%rectangle('position', [-map_size/2,-map_size/2, map_size, map_size],...
%          'facecolor',[1.0,1.0,1.0]);

% print the grid
for a = 1:size(map, 1);
    for b = 1:size(map, 2);
    % x and y are what you would expect from viewing the array
    x = robit_size*(b-len/2);
    y = robit_size*(a-len/2);
        % ### todo, fill at bump, not center
        if(bump && ...
            pos(1) >= x - robit_size/2 && ...
            pos(1) <= x + robit_size/2 && ...
            pos(2) >= y - robit_size/2 && ...
            pos(2) <= y + robit_size/2)
            map(a,b) = 1;
        end
        if map(a,b)==1
            rectangle('position', [x-robit_size/2,y-robit_size/2, ...
                robit_size,robit_size], ...
                'facecolor',[0,0,0]);
        end
    end
end

% finally, plot the position
plot(pos(1), pos(2), 'o');
% and the direction
plot([pos(1),pos(1)+vect_len*cos(pos(3))], ...
     [pos(2),pos(2)+vect_len*sin(pos(3))]);

end