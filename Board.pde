class Board {
  
  ArrayList<Plane> planes;
  
  // Constructor de la clase Tablón
  Board() {
    
    planes = new ArrayList<Plane>();
    
    // Planos del perímetro
    Plane up     = new Plane(100, 100, width - 100, 100);
    Plane down   = new Plane(100, height - 100, width - 100, height - 100);
    Plane left   = new Plane(100, 100, 100, height - 100);
    Plane right  = new Plane(width - 100, 100, width - 100, height - 100);
  
    // Planos interiores situados en los bordes
    Plane one    = new Plane(250, 300, 300, 250);
    Plane two    = new Plane(width - 250, 300, width - 300, 250);
    Plane three  = new Plane(250, height - 300, 300, height - 250);
    Plane four   = new Plane(width - 250, height - 300, width - 300, height - 250);

    // Planos interiores situados en el centro en forma de X
    Plane five   = new Plane(500, 500, 450, 450);
    Plane six    = new Plane(500, 500, 550, 550);
    Plane seven  = new Plane(500, 500, 450, 550);
    Plane eight  = new Plane(500, 500, 550, 450);
    
    planes.add(up);
    planes.add(down);
    planes.add(left);
    planes.add(right);
    
    planes.add(one);
    planes.add(two);
    planes.add(three);
    planes.add(four);
    
    planes.add(five);
    planes.add(six);
    planes.add(seven);
    planes.add(eight);
  }
  
  // Cálculo de las colisiones
  void update()
  {
    for (int i = planes.size()-1; i >= 0; i--)
    {
       Plane plane = planes.get(i);
       
       for (int j=0; j<balls.size(); j++)
       {
          Particle p = balls.get(j);
          plane.checkCollisions_ParticlePlane(p);
       }
    }
  }
  
  // Dibujado el pinball
  void display()
  {
      fill(0, 255, 0);
      strokeWeight(2);
      
      for (int i=0;i<planes.size();i++)
      {
        Plane plane = planes.get(i);
        line(plane.point1.x, plane.point1.y, plane.point2.x, plane.point2.y);
      }
  }
}
