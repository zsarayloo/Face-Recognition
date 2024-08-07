    clc;
    clear;
    close all;
for num=6:2:10


%% Problem Definition

global NFE;
NFE=0;
    
    CostFunction=@(x) MyCost(x,num);        % Cost Function
    
    nVar=100;       % Number of Decision Variables
    
    VarSize=[1 nVar];   % Size of Decision Variables Matrix
    
    VarMin=0;         % Lower Bound of Variables
    VarMax=1;         % Upper Bound of Variables
    
    
    %% PSO Parameters
    
    MaxIt=30;      % Maximum Number of Iterations
    
    nPop=100;        % Population Size (Swarm Size)
    
    w=1;            % Inertia Weight
    wdamp=0.99;     % Inertia Weight Damping Ratio
    c1=0.2;           % Personal Learning Coefficient
    c2=0.4;           % Global Learning Coefficient
    
    % % Constriction Coefficients
    % phi1=2.05;
    % phi2=2.05;
    % phi=phi1+phi2;
    % chi=2/(phi-2+sqrt(phi^2-4*phi));
    % w=chi;          % Inertia Weight
    % wdamp=1;        % Inertia Weight Damping Ratio
    % c1=chi*phi1;    % Personal Learning Coefficient
    % c2=chi*phi2;    % Global Learning Coefficient
    
    % Velocity Limits
    VelMax=0.1*(VarMax-VarMin);
    VelMin=-VelMax;
    
    %% Initialization
    
    empty_particle.Position=[];
    empty_particle.Cost=[];
    empty_particle.Sol=[];
    empty_particle.Velocity=[];
    empty_particle.Best.Position=[];
    empty_particle.Best.Cost=[];
    empty_particle.Best.Sol=[];
    
    particle=repmat(empty_particle,nPop,1);
    
    GlobalBest.Cost=inf;
    
    for i=1:nPop
        
        % Initialize Position
        particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
        
        % Initialize Velocity
        particle(i).Velocity=zeros(VarSize);
        
        % Evaluation
        [particle(i).Cost particle(i).Sol]=CostFunction(particle(i).Position);
        
        % Update Personal Best
        particle(i).Best.Position=particle(i).Position;
        particle(i).Best.Cost=particle(i).Cost;
        particle(i).Best.Sol=particle(i).Sol;
        
        % Update Global Best
        if particle(i).Best.Cost<GlobalBest.Cost
            
            GlobalBest=particle(i).Best;
            
        end
        
    end
    
    BestCost=zeros(MaxIt,1);
    
    nfe=zeros(MaxIt,1);
    
    
    %% PSO Main Loop
    
    for it=1:MaxIt
        
        for i=1:nPop
            
            % Update Velocity
            particle(i).Velocity = w*particle(i).Velocity ...
                +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
                +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
            
            % Apply Velocity Limits
            particle(i).Velocity = max(particle(i).Velocity,VelMin);
            particle(i).Velocity = min(particle(i).Velocity,VelMax);
            
            % Update Position
            particle(i).Position = particle(i).Position + particle(i).Velocity;
            
            % Velocity Mirror Effect
            IsOutside=(particle(i).Position<VarMin | particle(i).Position>VarMax);
            particle(i).Velocity(IsOutside)=-particle(i).Velocity(IsOutside);
            
            % Apply Position Limits
            particle(i).Position = max(particle(i).Position,VarMin);
            particle(i).Position = min(particle(i).Position,VarMax);
            
            % Evaluation
            [particle(i).Cost particle(i).Sol] = CostFunction(particle(i).Position);
            
            %         NewSol.Position=Mutate(particle(i).Position);
            %         [NewSol.Cost NewSol.Sol]=CostFunction(NewSol.Position);
            %         if NewSol.Cost<=particle(i).Cost
            %             particle(i).Position=NewSol.Position;
            %             particle(i).Cost=NewSol.Cost;
            %             particle(i).Sol=NewSol.Sol;
            %         end
            
            % Update Personal Best
            if particle(i).Cost<particle(i).Best.Cost
                
                particle(i).Best.Position=particle(i).Position;
                particle(i).Best.Cost=particle(i).Cost;
                particle(i).Best.Sol=particle(i).Sol;
                
                % Update Global Best
                if particle(i).Best.Cost<GlobalBest.Cost
                    
                    GlobalBest=particle(i).Best;
                    
                end
                
            end
            
        end
        
        %     NewSol.Position=Mutate(GlobalBest.Position);
        %     [NewSol.Cost NewSol.Sol]=CostFunction(NewSol.Position);
        %     if NewSol.Cost<=GlobalBest.Cost
        %         GlobalBest=NewSol;
        %     end
        
        BestCost(it)=GlobalBest.Cost;
        
        nfe(it)=NFE;
        
        disp(['Iteration ' num2str(it) ': NFE = ' num2str(nfe(it)) ', Best Cost = ' num2str(BestCost(it))]);
        
        w=w*wdamp;
        
        
    end
    
save(sprintf('PSO_feature_clr (%d).mat',num),'GlobalBest','nfe','BestCost')
    
end

%% Results

figure;
plot(nfe,BestCost,'LineWidth',2);
xlabel('NFE');
ylabel('Best Cost');

