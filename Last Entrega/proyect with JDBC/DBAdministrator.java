/*
	* COMO COMPILAR Y EJECUTAR
	* javac DBAdministrator.java
	* java -classpath ".:mysql-connector-java-5.0.8-bin.jar" DBAdministrator
*/
import java.sql.*;
import java.util.Scanner;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2003</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class DBAdministrator {

  public static String readString() {
    Scanner in = new Scanner(System.in);
    return in.nextLine();
  }

  public static int readInt() {
    Scanner in = new Scanner(System.in);
    return in.nextInt();
  }

  public static float readFloat() {
    Scanner in = new Scanner(System.in);
    return in.nextFloat(); 
  }

  public static long readLong() {
    Scanner in = new Scanner(System.in);
    return in.nextLong();  
  }

  public static void menu() {
    boolean salir = false;
    int option;

    while (!salir) {
      System.out.println("1) Agregar Menor");
      System.out.println("2) Eliminar Personal");
      System.out.println("3) Listar Visitas de un menor");
      System.out.println("4) Salir");

      option = readInt();

      switch (option) {
        case 1: addMenor();
                break;
        case 2: System.out.print("Indique el dni del personal que desea borrar: ");
                deletePersonal(readInt());
                break;
        case 3: System.out.print("Indique el dni del menor cuyas visitas desea conocer: ");
                listVisitas(readInt());
                break;
        case 4: salir = true;
                break;
        default: break;
      }
    }
  }

	public static void deletePersonal(int dni) {
		try {
			String driver = "org.gjt.mm.mysql.Driver";
        	//String driver = "com.mysql.jdbc.Driver";
        	String url = "jdbc:mysql://localhost:3306/ChildrenCity";
        	String username = "root";
        	String password = "root";
	
	        // Load database driver if not already loaded.
	        Class.forName(driver);
	        // Establish network connection to database.
	        Connection connection = DriverManager.getConnection(url, username, password);
	
	        connection.setAutoCommit(false); 
	
	        String personalDelete = "DELETE FROM Personal where nro_doc=?;";
	        PreparedStatement statement = connection.prepareStatement(personalDelete);
	        statement.setString(1, String.valueOf(dni));
	        statement.executeUpdate();
        	connection.commit();	
		} catch(ClassNotFoundException cnfe) {
        	System.err.println("Error loading driver: " + cnfe);
      	} catch(SQLException sqle) {
        	sqle.printStackTrace();
        	System.err.println("Error connecting: " + sqle);
      	} 		
	}

  public static void listVisitas(int dni) {
  		try {
          String driver = "org.gjt.mm.mysql.Driver";
        	String url = "jdbc:mysql://localhost:3306/ChildrenCity";
        	String username = "root";
        	String password = "root";
	
	        // Load database driver if not already loaded.
	        Class.forName(driver);
	        // Establish network connection to database.
	        Connection connection = DriverManager.getConnection(url, username, password);
	
	        connection.setAutoCommit(false); 
	
	        String verVisitas = "SELECT * FROM Visita where nro_doc_menor = ?;";
	        PreparedStatement statement = connection.prepareStatement(verVisitas);
	        statement.setString(1, String.valueOf(dni));
	        ResultSet resultSet = statement.executeQuery();
        	//connection.commit();	

	        // Print results.
     		while(resultSet.next()) {
        	// Quarter

        		System.out.print(" Nro visita: " + resultSet.getString(1));
        		System.out.print("; DNI Menor: " + resultSet.getString(2));
        		System.out.print("; DNI_Visitante: " + resultSet.getString(3));
        		System.out.print(" Fecha de Visita: " + resultSet.getString(4));
        		System.out.print(" Hora Llegada: " + resultSet.getString(5));
        		System.out.print(" Hora Salida: " + resultSet.getString(6));
            System.out.print("\n   ");
				    System.out.print("\n   ");
   			}

		} catch(ClassNotFoundException cnfe) {
        	System.err.println("Error loading driver: " + cnfe);
      	} catch(SQLException sqle) {
        	sqle.printStackTrace();
        	System.err.println("Error connecting: " + sqle);
      	}
  }

  public static void autoAddMenor() {
    try {
        String driver = "org.gjt.mm.mysql.Driver";
        String url = "jdbc:mysql://localhost:3306/ChildrenCity";
        String username = "root";
        String password = "root";

        // Load database driver if not already loaded.
        Class.forName(driver);
        // Establish network connection to database.
        Connection connection = DriverManager.getConnection(url, username, password);

        connection.setAutoCommit(false); 

        String useDBQuery = "use ChildrenCity";
        String menorInserter = "INSERT INTO `Menor` (`nro_doc`, `tipo_doc`, `apellido`, `nombre`, `estado`, `condicion`, `fecha_nac`, `peso`, `talla`, `telefono`, `nro_casa`, `nro_legajo`, `nro_hist`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

        PreparedStatement statement = connection.prepareStatement(menorInserter);
        statement.setInt(1, 38417696);
        statement.setString(2, "DNI");
        statement.setString(3, "Maria");
        statement.setString(4, "Santiago");
        statement.setString(5, "ingresado");
        statement.setString(6, "permanente");
        statement.setString(7, "1995-06-15");
        statement.setInt(8, 79);
        statement.setString(9, "XL");
        statement.setString(10, "3584023351");
        statement.setInt(11, 1);
        statement.setInt(12, 107);
        statement.setInt(13, 1);

        statement.executeUpdate();
        connection.commit();
     
      } catch(ClassNotFoundException cnfe) {
        System.err.println("Error loading driver: " + cnfe);
      } catch(SQLException sqle) {
        sqle.printStackTrace();
        System.err.println("Error connecting: " + sqle);
      }
    }

  public static void addMenor() {
    System.out.print("Ingrese el tipo de documento del menor: ");
    String dniType = readString();

    System.out.print("Ingrese el numero de documento del menor: ");
    int dni = readInt();

    System.out.print("Ingrese el nombre del menor: ");
    String name = readString();    

    System.out.print("Ingrese el apellido del menor: ");
    String lastName = readString();

    System.out.print("El menor es ingresado o egresado: ");
    String estado = readString();

    System.out.print("Tipo de estadia del menor (Dia/Permanente): ");
    String condicion = readString();

    System.out.print("Ingrese Fecha de nacimiento del menor en formato AAAA-MM-DD: ");
    String date = readString();

    System.out.print("Ingrese el peso del menor: ");
    float peso = readFloat();

    System.out.print("Ingrese la talla del menor (XS/S/M/L/XL): ");
    String talla = readString();

    System.out.print("Ingrese el telefono del menor: ");
    String phone = readString();

    System.out.print("Ingrese el numero de la casa donde esta el menor: ");
    int nro_casa = readInt();

    System.out.print("Ingrese el numero de legajo del menor: ");
    int nro_legajo = readInt();

    System.out.print("Puede el menor ser visitado? SI/NO: ");
    boolean puedeSerVisitado;
    String puede = readString().toLowerCase();
      if (puede.equals("si")) {
        puedeSerVisitado = true;
      }
      else {
        puedeSerVisitado = false;
      }

    System.out.print("Ingrese la direccion de la fotocopia de dni del menor: ");
    String url_dni = readString();

    System.out.print("Ingrese la direccion de la partida de nacimiento del menor: ");
    String url_partida = readString();    

    System.out.print("Ingrese la direccion de los informes de otros hogares del menor: ");
    String url_otherHogares = readString();

    /*System.out.print("Ingrese el numero de historial del menor: ");
    int nro_historial = readInt();*/

    System.out.println("--------------------Datos ingresados--------------");
    System.out.println("Nombre y apellido: "+name+" "+lastName);
    System.out.println("Documento: "+dniType+" "+dni);
    System.out.println("Fecha de nacimiento: "+date);
    System.out.println("Telefono: "+phone);
    System.out.println("Estado: "+estado);
    System.out.println("Condicion: "+condicion);
    System.out.println("Peso: "+peso);
    System.out.println("Talla: "+talla);
    System.out.println("Nro_casa: "+nro_casa);
    System.out.println("Nro_legajo: "+nro_legajo);
    //System.out.println("Nro_historial: "+nro_historial);
    System.out.println();
    System.out.println("Confirmar? Si/No");
    if ( (readString()).toLowerCase().equals("si") )  {
      try {
        String driver = "org.gjt.mm.mysql.Driver";
        String url = "jdbc:mysql://localhost:3306/ChildrenCity";
        String username = "root";
        String password = "root";

        // Load database driver if not already loaded.
        Class.forName(driver);
        // Establish network connection to database.
        Connection connection = DriverManager.getConnection(url, username, password);

        connection.setAutoCommit(false); 

        String useDBQuery = "use ChildrenCity";
        String insertLegajo = "INSERT INTO `Legajo` (`nro_legajo`, `visita_familiar`, `foto_dni`, `part_nac`, `otros_hogares`) values (?, ?, ?, ?, ?)";

          PreparedStatement statement = connection.prepareStatement(insertLegajo);
          statement.setInt(1, nro_legajo);
          statement.setBoolean(2, puedeSerVisitado);
          statement.setString(3, url_dni);
          statement.setString(4, url_partida);
          statement.setString(5, url_otherHogares);

          statement.executeUpdate();

          String insertHistory = "INSERT INTO `Historia_Clinica` (`nro_hist`) VALUES (null)";
            statement = connection.prepareStatement(insertHistory);
            statement.executeUpdate();

          String getCantHC = "SELECT count(nro_hist) FROM Historia_Clinica";
            statement = connection.prepareStatement(getCantHC);
            ResultSet cantHistoriaClinica = statement.executeQuery();
            int nro_historiaClinica = -1;

            while(cantHistoriaClinica.next()) {
              nro_historiaClinica = cantHistoriaClinica.getInt(1);
            }
            
        String menorInserter = "INSERT INTO `Menor` (`nro_doc`, `tipo_doc`, `apellido`, `nombre`, `estado`, `condicion`, `fecha_nac`, `peso`, `talla`, `telefono`, `nro_casa`, `nro_legajo`, `nro_hist`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

          statement = connection.prepareStatement(menorInserter);
          statement.setInt(1, dni);
          statement.setString(2, dniType);
          statement.setString(3, lastName);
          statement.setString(4, name);
          statement.setString(5, estado);
          statement.setString(6, condicion);
          statement.setString(7, date);
          statement.setFloat(8, peso);
          statement.setString(9, talla);
          statement.setString(10, phone);
          statement.setInt(11, nro_casa);
          statement.setInt(12, nro_legajo);
          statement.setInt(13, nro_historiaClinica);

          statement.executeUpdate();
        connection.commit();
     
      } catch(ClassNotFoundException cnfe) {
        System.err.println("Error loading driver: " + cnfe);
      } catch(SQLException sqle) {
        sqle.printStackTrace();
        System.err.println("Error connecting: " + sqle);
      }
    }
    else {
      System.out.println("Imposible realizar conexion");
    }
  }

  public static void main(String[] args) {
    menu();
  }
}
