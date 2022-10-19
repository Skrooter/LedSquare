n_rows = 5;
n_cols = 5;

PCB_size = 205;
frame_extra_size = 5;

ball_size = 40;
ball_distance = 41;
inner_wall_width = 0.5;

mouting_tab_height = 5;

frame_size_x = n_cols * ball_distance + frame_extra_size;
frame_size_y = n_rows * ball_distance + frame_extra_size;

ball_hole_size = ball_distance - inner_wall_width;

centering_ball_offset_col = (ball_distance * (n_cols - 1)) / 2;

centering_ball_offset_row = (ball_distance * (n_rows - 1)) / 2;
union(){
    // Main grid
    color("red",1)
    linear_extrude(height = 40,center = true,convexity = false,twist = false ,slices = false)
    difference(){

        
        square([frame_size_x,frame_size_y],center = true);


        for (col = [ 0 : n_cols - 1 ]) {
            for(row = [ 0 : n_rows - 1 ]) {
                translate([col * ball_distance - centering_ball_offset_col, row * ball_distance - centering_ball_offset_row, 0]) 
                square([ball_hole_size, ball_hole_size],center = true);
            }
        }
    }

    tab_length = 20;
    tab_width_x = (frame_size_x-PCB_size) / 2;
    tab_width_y = (frame_size_y-PCB_size) / 2;

echo (frame_size_x);
echo (PCB_size);    

    // mounting tabs
    translate([0,0, - 20 - mouting_tab_height / 2])
    linear_extrude(height = mouting_tab_height,center = true,convexity = false,twist = false ,slices = false)
    for(i = [0:1]){
        for(j = [0:1]) {
           
            translate([
            i * (n_cols / 2.5) * (ball_distance) - ball_distance,
            j * (frame_size_y - tab_width_y) + tab_width_y/2 - (frame_size_y / 2) , 
            0])
            square([tab_length, tab_width_y],center = true);
            
            translate([
            i * (frame_size_x - tab_width_x) + tab_width_x/2 - (frame_size_y / 2), 
            j * (n_rows / 2.5) * (ball_distance) - ball_distance, 
            0])
            square([tab_width_x, tab_length],center = true);
            
        }
    }
}