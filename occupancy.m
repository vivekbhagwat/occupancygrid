function map = occupancy(serPort)

goalError = 0.2; % distance from goal to hit
angleError = 0.1; % radians, before we start going towards goal

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
mapsize = 20;
map = zeros(mapsize);
bump = 0;

% drawing initialization
figure(1) % set the active figure handle to figure 1
plot_grid(map, pos, bump);

start_time = tic;

while(toc(start_time) < 10.0)
        DistanceSensorRoomba(serPort); % clear distance
    [br,bl, ~,~,~, bf] = BumpsWheelDropsSensorsRoomba(serPort);
    hit = (bf==1 || br==1 || bl==1);
    % move towards goal
    SetFwdVelRadiusRoomba(serPort, fs, inf);
    
    %MOVE AROUND RANDOMLY, HOPE SHIT DON'T BREAK.
    while(hit == 0 && dist(pos, goal)>goalError)
        % go for a little while
        pause(td);
        % poll the bumpers
        [br,bl, wr,wl,wc, bf] = BumpsWheelDropsSensorsRoomba(serPort);
        bump = br == 1 || bl == 1 || bf == 1;
        % if picked up, kill
        if (wr == 1 || wl == 1 || wc == 1)
            SetFwdVelRadiusRoomba(serPort, 0, 0);
            return;
        end
        hit = bump;
        d = DistanceSensorRoomba(serPort);
        pos(1) = pos(1) + d;
        % draw current location
        plot_grid(map, pos, bump);
    end
        
    SetFwdVelRadiusRoomba(serPort, 0, inf);

    % wall follow
    pos = wall_follower(serPort, pos);
    start_time = tic;
    
    plot_grid(map, pos, bump);
end

