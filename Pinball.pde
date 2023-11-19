Board board;
ArrayList<Particle> balls;

float dt      = 0.5;
float radius  = 20.0;
float Kr      = 0.99;

void setup()
{
  size(1000, 1000);
  
  board = new Board();
  balls = new ArrayList<Particle>(); 
}

void draw()
{
  background(150, 150, 150);
  rect (100, 100, 800, 800);
  
  // Actualización de las partículas
  for (int i = 0; i < balls.size(); i++)
  {
    Particle p = balls.get(i);
    p.update();
    
    for (int j=i+1;j<balls.size();j++){
      Particle q = balls.get(j);
      p.checkCollisions_ParticleParticle(q);
    }
    
    p.display();
  }
 
  // Cálculo de las las colisiones
  board.update();
  
  // Dibujado el pinball
  board.display(); 
}

void mousePressed()
{
  // A la pulsación del ratón por parte del usuario, introduce una nueva bola
  PVector pos = new PVector(mouseX, mouseY);
  Particle p  = new Particle(pos, radius);
  balls.add(p);
}
