function [ map ] = plot_grid( map, pos, bump )
% plot the current location, update the map

% robot size
size = 0.4;
% assume the map is square
len = length(map);
% how long to draw the direction vector
vect_len = 0.5;

% clear figure 1
clf;
mapsize = len*size;
axis([-mapsize/2 mapsize/2  -mapsize/2 mapsize/2]); % in meters
hold on; % don't clear figure with each plot()

% print the grid
for i = map;
    for j = map(i)
        % x and y are what you would expect from viewing the array
        x = size*(j-len/2);
        y = size*(i-len/2);
        % ### todo, fill at bump, not center
        if(bump && ...
            pos(1) >= x - 0.5 && ...
            pos(1) <= x + 0.5 && ...
            pos(2) <= y - 0.5 && ...
            pos(2) <= y + 0.5)
            map(i,j) = 1;
        end
        if map(i,j)==1
            rectangle('position', [x-0.5,y-0.5,1,1], ...
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