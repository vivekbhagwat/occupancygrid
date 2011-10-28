function [ map ] = plot_grid( map, pos, bump )
% plot the current location, update the map

% robot size
robit_size = 0.25;
% assume the map is square
len = length(map);
% how long to draw the direction vector
vect_len = 0.2;

disp(pos)

% print the grid
for a = 1:size(map, 1);
    for b = 1:size(map, 2);
        % x and y are what you would expect from viewing the array
        x = robit_size*(b-len/2);
        y = robit_size*(a-len/2);
        xc = pos(1) + robit_size*cos(pos(3));
        yc = pos(2) + robit_size*sin(pos(3));
        % fills in the obstacle at the bump sensor
        if(xc >= x - robit_size/2 && ...
           xc <= x + robit_size/2 && ...
           yc >= y - robit_size/2 && ...
           yc <= y + robit_size/2)
            if(bump==1)
                map(a,b) = 1;
            elseif(bump==0 && map(a,b) == -1)
                map(a,b) = 0;
            end
            if map(a,b)==1
                rectangle('position', [x-robit_size/2,y-robit_size/2, ...
                    robit_size,robit_size], ...
                    'edgecolor',[0,0,0], ...
                    'facecolor',[0,0,0]);
            elseif map(a,b)==0
                rectangle('position', [x-robit_size/2,y-robit_size/2, ...
                    robit_size,robit_size], ...
                    'edgecolor',[1,1,1], ...
                    'facecolor',[1,1,1]);
            end
        end
    end
end

% finally, plot the position
plot(pos(1), pos(2), 'o');
% and the direction
plot([pos(1),pos(1)+vect_len*cos(pos(3))], ...
     [pos(2),pos(2)+vect_len*sin(pos(3))]);

end