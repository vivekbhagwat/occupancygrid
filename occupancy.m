function map = occupancy(serPort)

if isSimulator(serPort)
    td = 0.1; % time delta to wait
    fs = 0.1; % forward speed
    as = 0.2; % angle speed (0, 0.2 m/s)    
    corrective = 1.0; %.5; % how much to fix the angle deltas by
else
    td = 0.01;
    fs = 0.1;
    as = 0.02;
    corrective = 1.5; 
end

pos = [0,0,0]; % [x,y,theta]

% map size in terms of 
mapsize = 10;
map = zeros(mapsize);
bump = 0;

% drawing initialization

robit_size = 0.3; % also set it in plot_grid
figure(1) % set the active figure handle to figure 1
clf; % clear figure 1
len = length(map); % assume the map is square
mapsize = len*robit_size * 1.2;
axis([-mapsize/2 mapsize/2  -mapsize/2 mapsize/2]); % in meters
hold on; % don't clear figure with each plot()

plot_grid(map, pos, bump);

start_time = tic;

while(toc(start_time) < 10.0)
        DistanceSensorRoomba(serPort); % clear distance
    [br,bl, ~,~,~, bf] = BumpsWheelDropsSensorsRoomba(serPort);
    bump = (bf==1 || br==1 || bl==1);
    
    % move around randomly.
    SetFwdVelRadiusRoomba(serPort, fs, inf);
    
    %KEEP MOVING AROUND RANDOMLY, HOPE SHIT DON'T BREAK.
    while(bump == 0)
        % go for a little while
        pause(td);
        % poll the bumpers
        [br,bl, wr,wl,wc, bf] = BumpsWheelDropsSensorsRoomba(serPort);
        bump = (br == 1 || bl == 1 || bf == 1);
        % if picked up, kill
        if (wr == 1 || wl == 1 || wc == 1)
            SetFwdVelRadiusRoomba(serPort, 0, 0);
            return;
        end
        d = DistanceSensorRoomba(serPort);

        pos(1) = pos(1) + d;
        % draw current location
        plot_grid(map, pos, bump);
    end
        
    SetFwdVelRadiusRoomba(serPort, 0, inf);

    % wall follow
    pos = wall_follower(serPort, map, pos);
    start_time = tic;
    
    plot_grid(map, pos, bump);
end

