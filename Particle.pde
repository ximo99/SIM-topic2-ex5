class Particle
{
  float mass = 1.0;
  PVector place;
  PVector vel;
  PVector a;
  float rad;
  PVector gravity;
  
  // Constructor de la clase Partícula
  Particle(PVector local, float r) {
    
    place   = local.get();
    vel     = new PVector(random(-10, 10), random(-10, 10));
    a       = new PVector();
    gravity = new PVector(0,0);
    rad     = r;
  }
  
  void applyForce(PVector f)
  {
    PVector force = PVector.div(f.get(), mass);
    a.add(force);
  }
  
  void run()
  {
    update();
    display();
  }
  
  void display()
  {
    fill(255,0,0);
    ellipse(place.x, place.y, rad, rad);
  }
  
  // Integración mediante el método de Euler simpléctico
  void update()
  {
    applyForce(gravity);
    vel.add(PVector.mult(a, dt));
    place.add(PVector.mult(vel,dt));
    a.set(0,0);
  }
  
  // Cálculo de las colisiones entre partículas
  void checkCollisions_ParticleParticle(Particle p)
  {
    PVector d = PVector.sub(this.place, p.place);
    float dist = d.mag();
    
    // Deteccción de la colision (si la distancia es menor al radio de la partícula)
    if(dist < rad)
    {
      PVector unitD = new PVector();
      unitD.set(d);
      unitD.normalize();

      PVector norm1 = PVector.mult(unitD, (this.vel.dot(d) / dist) );
      PVector t1 = PVector.sub(this.vel, norm1);
      
      PVector norm2 = PVector.mult(unitD, (p.vel.dot(d) / dist) );
      PVector tan2 = PVector.sub(p.vel, norm2);
      
      float restitution = (this.rad + p.rad) - dist;
      PVector subs = PVector.sub(norm1, norm2);
      
      // Cálculo de la velocidad relativa (diferencia de las normales)
      float vrel = subs.mag();
      
      PVector multnorm1 = PVector.mult(norm1, -restitution / vrel);
      this.place.add(multnorm1);
      
      PVector multnorm2 = PVector.mult(norm2, -restitution / vrel);
      p.place.add(multnorm2);
      
      // Cálculo de la velocidad de las partículas después de la colisión    
      float mass1 = this.mass;
      float mass2 = p.mass;
      
      float u1 = norm1.dot(d) / dist;
      float u2 = norm2.dot(d) / dist; 
      
      float v1 = ( (mass1 - mass2) * u1 + 2 * mass2 * u2) / (mass1 + mass2);
      norm1 = PVector.mult(unitD, v1);
      
      float v2 = ( (mass2 - mass1) * u2 + 2 * mass1 * u1) / (mass1 + mass2);
      norm2 = PVector.mult(unitD, v2);

      this.vel = PVector.add(norm1, t1); 
      p.vel = PVector.add(norm2, tan2);
    }
  }
}
