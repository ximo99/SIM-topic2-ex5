class Plane{
  PVector point1, point2;
  PVector plane, normal;
  PVector dCol, uni;
  PVector dif1, dif2;
  PVector norm_plane, norm, tangent, reposition;

  float scalarP1_plane, scalarP2_plane, module_plane;
  float p1, p2;

  float nv, delta_s, ang;

  // Constructor de la clase Plano
  Plane(float x1, float y1, float x2, float y2) {

    point1 = new PVector(x1,y1);
    point2 = new PVector(x2,y2);

    // Cálculo de un plano a partir de dos puntos dados
    plane  = PVector.sub(point2, point1);

    // Cálculo de la normal del plano
    normal =  new PVector(-plane.y, plane.x);
    normal.normalize();
  }

  // Cálculo de las colisiones de la partícula con el plano
  void checkCollisions_ParticlePlane(Particle p)
  {
    dif1 = PVector.sub(point1, p.place); 
    dif2 = PVector.sub(point2, p.place);

    uni = new PVector(0,0);
    module_plane = plane.mag();

    scalarP1_plane = dif1.dot(plane);
    p1 = scalarP1_plane / module_plane;

    scalarP2_plane = dif2.dot(plane);
    p2 = scalarP2_plane / module_plane;

    uni.set(plane);
    uni.normalize();

    dCol = PVector.add(dif1, PVector.mult(uni, p1 * (-1)));

    if(abs(p1) < module_plane && abs(p2) < module_plane)
    {
      if(dCol.mag() < radius)
      {
        norm_plane = normal.get();

        if(norm_plane.dot(p.vel) > 0)
           norm_plane.mult(-1);

        ang = PVector.angleBetween(p.vel, plane);

        delta_s = (radius + dCol.dot(norm_plane)) / sin(ang);
        
        reposition = PVector.mult(norm_plane, delta_s);
        p.place.add(reposition);
        
        nv      = normal.dot(p.vel);
        norm    = PVector.mult(normal, nv);
        tangent = PVector.sub(p.vel, norm); 
        p.vel   = PVector.sub(tangent, PVector.mult(norm, Kr));
      }
    }
  }
}
