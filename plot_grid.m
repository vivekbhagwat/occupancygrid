function [ map ] = plot_grid( map, pos, bf, br, bl )
% plot the current location, update the map

% robot size
robit_size = 0.25;
% assume the map is square
len = length(map);
% how long to draw the direction vector
vect_len = 0.2;

disp(pos)
bump = (bf == 1 || br == 1 || bl == 1);
angle = 0;
if( br == 1 )
    angle = -pi/4;
elseif( bl == 1 )
    angle = pi/4;
end

change = 0;

% print the grid
for a = 1:size(map, 1);
    for b = 1:size(map, 2);
        % x and y are what you would expect from viewing the array
        x = robit_size*(b-len/2);
        y = robit_size*(a-len/2);
        xc = pos(1);
        yc = pos(2);
        xb = pos(1) + robit_size/2*cos(pos(3)+angle);
        yb = pos(2) + robit_size/2*sin(pos(3)+angle);
        % fill in non-occ if you go
        if(xc >= x - robit_size/2 && ...
           xc <= x + robit_size/2 && ...
           yc >= y - robit_size/2 && ...
           yc <= y + robit_size/2)
            if(bump==0 && map(a,b) == -1)
                map(a,b) = 0;
                change = 1;
            end
        end
        % fills in the obstacle at the bump sensor
        if(xb >= x - robit_size/2 && ...
           xb <= x + robit_size/2 && ...
           yb >= y - robit_size/2 && ...
           yb <= y + robit_size/2)
            if(bump==1)
                map(a,b) = 1;
                change = 1;
            elseif(bump==0 && map(a,b) == -1)
                map(a,b) = 0;
                change = 1;
            end
        end
        % draws current thing
        if map(a,b)==1 && change == 1
            rectangle('position', [x-robit_size/2,y-robit_size/2, ...
                robit_size,robit_size], ...
                'edgecolor',[0,0,0], ...
                'facecolor',[0,0,0]);
        elseif map(a,b)==0 && change == 1
            rectangle('position', [x-robit_size/2,y-robit_size/2, ...
                robit_size,robit_size], ...
                'edgecolor',[1,1,1], ...
                'facecolor',[1,1,1]);
        end
    end
end

% finally, plot the position
plot(pos(1), pos(2), 'o');
% and the direction
plot([pos(1),pos(1)+vect_len*cos(pos(3))], ...
     [pos(2),pos(2)+vect_len*sin(pos(3))]);

end